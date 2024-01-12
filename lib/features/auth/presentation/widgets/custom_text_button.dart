import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool selected;

  const CustomTextButton(
      {Key? key,
      required this.onTap,
      required this.text,
      this.selected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              color: selected ? Colors.white : Colors.grey,
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (selected)
            Container(
              height: 3,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                  color: const Color(0xffE0C356),
                  borderRadius: BorderRadius.circular(8)),
              width: text.length.toDouble() * 8,
            )
        ],
      ),
    );
  }
}
