import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    super.key,
    required this.controller,
    this.validator,
    required this.hintText,
    required this.title,
    this.maxLines,
  });
  final TextEditingController controller;
  final String hintText;
  final String title;
  final int? maxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium
        ),
        SizedBox(height: 8),
        TextFormField(
          validator: validator != null ? (v) => validator!(v) : null,
          maxLines: maxLines,
          controller: controller,
          decoration: InputDecoration(hintText: hintText),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
