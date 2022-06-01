import 'package:flutter/material.dart';
//https://www.youtube.com/watch?v=ABmqtI7ec7E&list=PL4cUxeGkcC9jLYyp2Aoh6hcWuxFDX6PBJ&index=10
void main() {
  runApp(MaterialApp(
    home: Home()
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int incomeTotal = 0;
  int expenseTotal = 0;
  int diff = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Text(
            'TOTAL INCOME',
            style: TextStyle(
              color: Colors.grey,
              letterSpacing: 2.0,
                  )
              ),
            SizedBox(height: 10.0),
            Text(
                '$incomeTotal',
                style: TextStyle(
                    color: Colors.lightGreen,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold
            )
        ),
        SizedBox(height: 40.0),
            Text(
                'TOTAL EXPENSE',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                )
            ),
            SizedBox(height: 10.0),
            Text(
                '$expenseTotal',
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold
                )
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child:
        Text("+"),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
