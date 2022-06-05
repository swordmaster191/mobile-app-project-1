import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:lottie/lottie.dart';
import 'dart:convert';

import 'ExpandableFab.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int expenseTotal = 0;
  int expenseGoal = 0;
  String animationPath = "";
  String title = "This is the default value";
  String desc = "Something is wrong with the code I assume :(";
  LottieBuilder happy = Lottie.asset(
    "assets/thumbsup.json",
    repeat: true,
  );
  LottieBuilder neutral = Lottie.asset(
    "assets/warning.json",
    repeat: true,
  );
  LottieBuilder sad = Lottie.asset(
    "assets/sad.json",
    repeat: true,
  );
  static const _goalTitle = ['Great job!', 'Watch out!', 'Oh no!'];
  static const _goalDesc = ['You are currently on track for your goal!', 'Try limiting your expenses!', 'You have went over your goal :('];

  var expenseTotalFormatter;
  var expenseGoalFormatter;
  LottieBuilder updateState(){
    expenseTotalFormatter = intl.NumberFormat.decimalPattern().format(expenseTotal).toString();
    expenseGoalFormatter = intl.NumberFormat.decimalPattern().format(expenseGoal).toString();

    if(expenseTotal > expenseGoal){
      title = _goalTitle.elementAt(2);
      desc = _goalDesc.elementAt(2);
      return sad;
    }
    else if(expenseTotal/expenseGoal >= 0.50){
      title = _goalTitle.elementAt(1);
      desc = _goalDesc.elementAt(1);
      return neutral;
    }
    else{
      title = _goalTitle.elementAt(0);
      desc = _goalDesc.elementAt(0);
      return happy;
    }


  }

  Text getTitleWithFormat(){
    if(expenseTotal > expenseGoal){
      return Text(
          '$title',
          style: TextStyle(
              color: Colors.red,
              fontSize: 40.0,
              fontWeight: FontWeight.bold
          )
      );
    }
    else if(expenseTotal/expenseGoal >= 0.5){
      return Text(
          '$title',
          style: TextStyle(
              color: Colors.orangeAccent,
              fontSize: 40.0,
              fontWeight: FontWeight.bold
          )
      );
    }
    else{
      return Text(
          '$title',
          style: TextStyle(
              color: Colors.green,
              fontSize: 40.0,
              fontWeight: FontWeight.bold
          )
      );
    }


  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Dejariana"),
        backgroundColor: Colors.grey[850],
        centerTitle: true,
        elevation: 0.0,
      ),

      body:Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            updateState(),
            SizedBox(height: 10.0),
            Center(
              child: Column(
                  children: <Widget>[
                    getTitleWithFormat(),
                    SizedBox(height: 10.0),
                Text(
                    '$desc',
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold
                    )
                ),
              ]
              ),
            ),
            Divider(
              height: 50.0,
              color: Colors.grey[800],
            ),
            Text(
                'TOTAL EXPENSES',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                )
            ),
            SizedBox(height: 10.0),
            Text(
                '$expenseTotalFormatter',
                style: TextStyle(
                    color: Colors.amberAccent[200],
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold
                )
            ),
            SizedBox(height: 20.0),
            Text(
                'CURRENT GOAL',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                )
            ),
            SizedBox(height: 10.0),
            Text(
                '$expenseGoalFormatter',
                style: TextStyle(
                    color: Colors.amberAccent[200],
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold
                )
            ),
          ],
        ),
      ),
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDataAlert();
        },
        child:
          Icon(Icons.menu),
          backgroundColor: Colors.blue,
      ),*/
      floatingActionButton: ExpandableFab(
        distance: 75,
        children: [
          ActionButton(
            onPressed: () async{
              await addDataAlert();
              setState((){});
            },
              icon: const Icon(Icons.add),
          ),
          ActionButton(
            onPressed: () async{
              await editGoalAlert();
              setState((){});
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),

    );
  }
  Future addDataAlert() {
    final _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: EdgeInsets.only(
              top: 10.0,
            ),
            title: Text(
              "Log expenses",
              style: TextStyle(fontSize: 24.0),
            ),
            content:
            Container(
              height: 270,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        " Add expense amount",
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                onSaved: (String? value){
                                  if (value != null){
                                    expenseTotal += int.parse(value);
                                  }
                                  },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter your amount here',
                                    labelText: 'Amount'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState?.save();
                            print(expenseTotal);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Saved!')),
                            );
                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          // fixedSize: Size(250, 50),
                        ),
                        child: Text(
                          "Submit",
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent,
                          // fixedSize: Size(250, 50),
                        ),
                        child: Text(
                          "Cancel",
                        ),
                      ),
                    ),
                    /*
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Note'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'The data will only be used to calculate the current expenses, no data will be logged or linked to your device or ID.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
          )
    ),
    );
  }
  Future editGoalAlert() {
    final _formKey = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              20.0,
            ),
          ),
        ),
        contentPadding: EdgeInsets.only(
          top: 10.0,
        ),
        title: Text(
          "Edit expenses goal",
          style: TextStyle(fontSize: 24.0),
        ),
        content:
        Container(
          height: 270,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    " Edit value",
                  ),
                ),
                Container(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                onSaved: (String? value){
                                  if (value != null){
                                    expenseGoal = int.parse(value);
                                  }
                                },
                                initialValue: expenseGoal.toString(),
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter your goal here',
                                    labelText: 'Amount'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Goal updated!')),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      // fixedSize: Size(250, 50),
                    ),
                    child: Text(
                      "Submit",
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      // fixedSize: Size(250, 50),
                    ),
                    child: Text(
                      "Cancel",
                    ),
                  ),
                ),
                /*
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Note'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'The data will only be used to calculate the current expenses, no data will be logged or linked to your device or ID.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),*/
              ],
            ),
          ),
        ),
      )
      ),
    );
  }
}



