import 'package:flutter/material.dart';
//https://www.youtube.com/watch?v=km2P_KQJyO0&list=PL4cUxeGkcC9jLYyp2Aoh6hcWuxFDX6PBJ&index=6
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
        child: Text(
          "Test 123",
          style: TextStyle(
            fontSize: 25.0,
            letterSpacing: 2.0,
            color: Colors.grey[600],
          ),
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
