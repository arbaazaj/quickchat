import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.prefixIcon,
      required this.hintText, required this.controller, this.keyboardType, required this.obscureText});

  final IconData? prefixIcon;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        obscureText: obscureText,
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        cursorColor: Colors.deepPurple,
        style: const TextStyle(
            color: Colors.deepPurple, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: Colors.deepPurple),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.deepPurple.shade300),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(
                color: Colors.deepPurple, width: 2.0, style: BorderStyle.solid),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.deepPurple,
                width: 10.0,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
    );
  }
}
