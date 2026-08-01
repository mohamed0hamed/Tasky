import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({super.key,required this.onChanged, required this.value});
  final void Function(bool?) onChanged ;
  final bool value ;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(color: Color(0xffD1DAD6), width: 2),
      ),
      activeColor: Color(0xff15B86C),
      value: value,
      onChanged: (value) => onChanged(value)
    );
  }
}
