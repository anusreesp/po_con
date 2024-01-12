import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../dashboard.dart';

final dialogBoxProvider = Provider((ref) {
  return DialogBox();
});

class DialogBox {
  confirmationPopup(
    BuildContext context,
    String imgPath,
    String title,
    String content,
    bool justClose,
  ) {
    return Dialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black,
            border:
                Border.all(color: Colors.yellow.withOpacity(0.4), width: 0.7)),
        height: 180,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 50),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: ClipRRect(
                    child: Image.asset("assets/images/$imgPath"),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        justClose
                            ? Navigator.of(context).pop()
                            : Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Dashboard()));
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.grey,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              // "Request Sent",
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 12,
            ),
            // Container(
            //   width: 160,
            content != ''
                ? Text(
                    // "Our support team will get back to you shortly",
                    content,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color.fromARGB(255, 192, 192, 192)
                            .withOpacity(0.6),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    // ),
                  )
                : Container(),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
