import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  IconData iconData;
  AuthTextField(
      {required this.controller,
      required this.hintText,
      required this.iconData,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        title: TextField(
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey)),
        ),
        trailing: Icon(iconData),
      ),
    );
  }
}
