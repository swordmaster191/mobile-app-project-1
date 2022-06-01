import 'package:flutter/material.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();


}

class _AddDataState extends State<AddData> {
  final _formKey = GlobalKey<FormState>();
  final List<String> type = ['Income', 'Expense'];

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Dejariana"),
        backgroundColor: Colors.grey[850],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
      child: Form(
      key: _formKey,
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
              'TYPE',
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
