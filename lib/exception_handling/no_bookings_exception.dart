import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoEntryBooking extends ConsumerWidget {
  final String content;
  const NoEntryBooking({super.key, required this.content});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(child: buildBody(content, context));
  }

  Widget buildBody(String content, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.055,
        ),
        Image.asset(
          "assets/images/exception_image.png",
          fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width * 0.50,
          height: MediaQuery.of(context).size.height * 0.27,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.025,
        ),
        Text(
          "$content .\n Refresh or try again later",
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        )
      ],
    );
  }
}
