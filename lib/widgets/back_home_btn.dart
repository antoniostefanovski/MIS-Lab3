import 'package:flutter/material.dart';

class BackHomeBtn extends StatelessWidget {
  const BackHomeBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context),
        backgroundColor: Colors.red[50],
        tooltip: 'Go back to home screen',
        icon: const Icon(Icons.arrow_back, color: Colors.black,),
        label: const Text("Home", style: TextStyle(color: Colors.black),
        ));
  }
}
