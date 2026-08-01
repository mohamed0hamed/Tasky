import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key,required this.onPressed, required this.label,  this.icon});
final void Function() onPressed;
final String label;
final IconData? icon ;
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                  backgroundColor: Color(0xff15B86C),
                  foregroundColor: Color(0xffFFFCFC),
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                icon: Icon(icon),
                label: Text(label),
              );
  }
}