import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextForm extends StatelessWidget {
  CustomTextForm({
    required this.title,
    required this.screenWidth,
    this.isObsecure = false,
    required this.controller,
    super.key,
  });

  String title;
  double screenWidth;
  bool isObsecure;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: screenWidth * 0.02),
      child: TextFormField(
        controller: controller,
        obscureText: isObsecure,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(20),
          hintText: title,
        ),
      ),
    );
  }
}
