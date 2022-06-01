import 'package:flutter/material.dart';
//https://www.youtube.com/watch?v=ABmqtI7ec7E&list=PL4cUxeGkcC9jLYyp2Aoh6hcWuxFDX6PBJ&index=10
void main() {
  runApp(MaterialApp(
    home: Home()
  ));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dejariana"),
        backgroundColor: Colors.green,
      ),

      body: Center(
        child:RaisedButton.icon(
          onPressed: (){},
          icon: Icon(
            Icons.mail
          ),
          label: Text(
          "Test 123",
          style: TextStyle(
            fontSize: 25.0,
            letterSpacing: 2.0,
            color: Colors.grey[600],
            ),
          ),
          color: Colors.amber,
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
