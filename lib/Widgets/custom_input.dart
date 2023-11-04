import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final VoidCallback? onTap;
  final InputDecoration? decoration;
  final BorderRadius? borderRadius;

  const CustomInput(
      {super.key,
      this.controller,
      required this.title,
      this.decoration,
      this.borderRadius, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade700,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        onTap: onTap ,
        controller: controller,
        decoration: decoration ??
            InputDecoration(hintText: title, border: InputBorder.none),
      ),
    );
  }
}
