import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String src;
  const DetailScreen({required this.src, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'ProfilePicture',
            child: Image.network(src),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
