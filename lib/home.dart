import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';
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
  String? selectedValue = null;
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
  List<List<String>> _expenseDatabase = [];
  static const _goalTitle = ['Great job!', 'Watch out!', 'Oh no!'];
  static const _goalDesc = ['You are currently on track for your goal!', 'Try limiting your expenses!', 'You have went over your goal :('];
  TextEditingController dateinput = TextEditingController();
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
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Food"),value: "Food"),
      DropdownMenuItem(child: Text("Utilities"),value: "Utilities"),
      DropdownMenuItem(child: Text("Insurance"),value: "Insurance"),
      DropdownMenuItem(child: Text("Medical"),value: "Medical"),
      DropdownMenuItem(child: Text("Saving & Investment"),value: "Saving & Investment"),
      DropdownMenuItem(child: Text("Personal Spending"),value: "Personal Spending"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownIncome{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Salary"),value: "Salary"),
      DropdownMenuItem(child: Text("Personal Savings"),value: "Personal Savings"),
    ];
    return menuItems;
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
      floatingActionButton: SpeedDial(
        spacing: 12,
        spaceBetweenChildren: 12,
        animatedIcon: AnimatedIcons.menu_close,
        overlayColor: Colors.black,
        overlayOpacity: 0.95,
        children: [
          SpeedDialChild(
            child: Icon(Icons.list_alt_sharp),
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            label: 'Manage/View entries',
            onTap: () async{
              await editGoalAlert();
              setState((){});
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.edit),
            backgroundColor: Colors.amberAccent[200],
            foregroundColor: Colors.white,
            label: 'Set spending goal',
            onTap: () async{
              await editGoalAlert();
              setState((){});
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.account_balance_wallet_sharp),
            backgroundColor: Colors.redAccent[200],
            foregroundColor: Colors.white,
            label: 'Add an expense',
            onTap: () async{
              await addDataAlert();
              setState((){});
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.account_balance_sharp),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            label: 'Add an income',
            onTap: () async{
              await addDataAlert();
              setState((){});
            },
          )
        ],
      ),
    );
  }
  Future addDataAlert() {
    final _formKey = GlobalKey<FormState>();
    final _formKey2 = GlobalKey<FormState>();
    final _formKey3 = GlobalKey<FormState>();
    String categoryData = "";
    String amountData = "";
    String dateData = "";

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
              "Add an expense",
              style: TextStyle(fontSize: 24.0),
            ),
            content:
            Container(
              height: 490,
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
                                    amountData = value;
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
                    ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        " Select category"
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey2,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Select the category here',
                                      labelText: 'Category'),
                                  items: dropdownItems,
                                  value: selectedValue,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedValue = newValue!;
                                    });
                                  },
                                  onSaved: (String? value){
                                    if (value != null){
                                      categoryData = value;
                                    }
                                  },
                                  validator: (value) {
                                    if (selectedValue == null) {
                                      return 'Please enter a value';
                                    }
                                    return null;
                                  },

                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          " Date of Transaction"
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey3,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter the date here',
                                      labelText: 'Date'),
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Colors.black,
                                  controller: dateinput,
                                  //editing controller of this TextField
                                  readOnly: true,
                                  onSaved: (String? value){
                                    if (value != null){
                                      dateData = value;
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a value';
                                    }
                                    return null;
                                  },
                                  //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101)
                                    );

                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate = DateFormat('yyyy-MM-dd').format(
                                          pickedDate);
                                      print(
                                          formattedDate); //formatted date output using intl package =>  2021-03-16
                                      //you can implement different kind of Date Format here according to your requirement

                                      setState(() {
                                        dateinput.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),



                    Container(
                      width: double.infinity,
                      height: 60,
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() && _formKey2.currentState!.validate() && _formKey3.currentState!.validate()) {
                            _formKey.currentState?.save();
                            _formKey2.currentState?.save();
                            _formKey3.currentState?.save();

                            selectedValue = "";

                            _expenseDatabase.add([dateData, categoryData, amountData]);
                            print(_expenseDatabase);

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
                          selectedValue = "";
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
    final _formKey2 = GlobalKey<FormState>();
    final _formKey3 = GlobalKey<FormState>();
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
              ],
            ),
          ),
        ),
      )
      ),
    );
  }
}



