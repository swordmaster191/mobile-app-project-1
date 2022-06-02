import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static int incomeTotal = 0;
  static int expenseTotal = 0;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String diff = '';
  final incomeFormatter =  intl.NumberFormat.decimalPattern().format(Home.incomeTotal);
  final expenseFormatter =  intl.NumberFormat.decimalPattern().format(Home.expenseTotal);

  void setDiff(){
    diff = intl.NumberFormat.decimalPattern().format((Home.incomeTotal - Home.expenseTotal));
  }

  @override
  void initState() {
    setDiff();
    super.initState();
  }

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
                '$incomeFormatter',
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
                '$expenseFormatter',
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold
                )
            ),
            SizedBox(height: 40.0),
            Text(
                'NET DIFFERENCES',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                )
            ),
            SizedBox(height: 10.0),
            Text(
                '$diff',
                style: TextStyle(
                    color: (Home.incomeTotal - Home.expenseTotal) > 0 ? Colors.lightGreen : Colors.redAccent,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold
                )
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/adddata');
        },
        child:
        Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}