import 'package:flutter/material.dart';

showSnackBar({required context, required content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      duration: const Duration(seconds: 5),
    ),
  );
}
