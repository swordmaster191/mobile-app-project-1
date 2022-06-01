import 'package:flutter/material.dart';
//https://www.youtube.com/watch?v=km2P_KQJyO0&list=PL4cUxeGkcC9jLYyp2Aoh6hcWuxFDX6PBJ&index=6
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("Dejariana"),
      ),

      body: Center(
        child: Text("Test 123"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child:
          Text("+"),
      ),
    ),
  ));
}