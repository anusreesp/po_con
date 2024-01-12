
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final VoidCallback onTap;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
   const CustomButton({Key? key,this.height=40,this.width=100,required this.child,required this.onTap,this.margin,this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: margin,
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors:[Color(0xffF7CE73),Color(0xffDBA611)]),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(child:child),
      ),
    );
  }
}
