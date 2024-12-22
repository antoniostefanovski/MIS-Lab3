import 'package:flutter/material.dart';

class RouteButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String btnText;

  const RouteButton({super.key, required this.onPressed, required this.btnText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(btnText),
      ),
    );
  }
}
