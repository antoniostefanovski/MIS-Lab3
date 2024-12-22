import 'package:flutter/material.dart';

class RandomJokeType extends StatelessWidget {
  final int id;
  final String type;

  const RandomJokeType({super.key, required this.id, required this.type});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.white,
      label: Text(type, style: TextStyle(
          fontSize: 24, color: Colors.red[900]
      ),),
      avatar: CircleAvatar(backgroundColor: Colors.red[50],
          child: Text(id.toString())),
    );
  }
}
