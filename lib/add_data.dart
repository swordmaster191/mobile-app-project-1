import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();


}

class _AddDataState extends State<AddData> {
  final _formKey = GlobalKey<FormState>();
  final List<String> type = ['Income', 'Expense'];
  final List<String> category = [
    'Food',
    'Utilities',
    'Insurance',
    'Medical',
    'Saving & Investment',
    'Personal Spending'
  ];
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  String currentSelectedType = "";

  void getType() async {
    Future<String> futureString = showTypeCategories(context);
    if (await futureString != null) {
      currentSelectedType = await futureString;
    }
  }


  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Add Data"),
        backgroundColor: Colors.grey[850],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    'NAME',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    )
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40.0),
                Text(
                    'DATE',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    )
                ),
                SizedBox(height: 10.0),
                TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: dateinput,
                  //editing controller of this TextField
                  readOnly: true,
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
                SizedBox(height: 40.0),
                Text(
                    'TYPE',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    )
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  // The validator receives the text that the user has entered.
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  onTap: () {
                    showTypeCategories(context);
                    setState(() {
                      _textEditingController.text = currentSelectedType;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40.0),
                Text(
                    'CATEGORY',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    )
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  // The validator receives the text that the user has entered.
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40.0),
                Text(
                    'AMOUNT',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    )
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  // The validator receives the text that the user has entered.
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),),
              ],
            ),),),),
    );
  }

  Future<String> showTypeCategories(context) async {
    var result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.grey[900],
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            'Select type',
            style: TextStyle(color: Colors.grey),
          ),
          children: <Widget>[
            Column(
              children: List.generate(
                type.length,
                    (index) {
                  return SimpleDialogOption(
                    child: ListTile(
                      leading: Icon(
                          Icons.bookmark,
                        color: Colors.white,
                      ),
                      title: Text(
                          type[index],
                          style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, type[index]);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );

    switch (result) {
      case 'Income':
        return "Income";
      case 'Expense':
        return "Expense";
    }
    return "";
  }
}
