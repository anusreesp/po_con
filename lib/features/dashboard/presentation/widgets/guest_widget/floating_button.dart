import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_concierge/features/dashboard/presentation/widgets/guest_widget/animated_toggle.dart';

import '../../../controller/widget_controller/floating_button_controller.dart';

class AnimatedFloatingButton extends ConsumerWidget {
  final String docId, collectionName;
  final DateTime bookedDate;
  final bool isChecked;
  const AnimatedFloatingButton(
      {super.key,
      required this.docId,
      required this.bookedDate,
      required this.isChecked,
      required this.collectionName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final controller = ref.watch(isCheckedProvider);
    final statusController = ref.watch(statusProvider);

    return (statusController == 'Completed')
        ? afterConfirmation(55)
        : AbsorbPointer(
            absorbing: false,
            child: AnimatedToggle(
              documentId: docId,
              collectionName: collectionName,
              bookedDate: bookedDate,
            ),
          );
  }

  Widget afterConfirmation(
    double? height,
  ) {
    return SizedBox(
      height: height ?? 50,
      child: const Padding(
        padding: EdgeInsets.all(4.0),
        child: Center(
            child: Text(
          "Checked In",
          style: TextStyle(
              color: Color(
                0xffD5A218,
              ),
              fontSize: 16),
        )),
      ),
    );
  }
}
