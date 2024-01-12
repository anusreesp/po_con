import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_concierge/features/dashboard/controller/widget_controller/floating_button_controller.dart';
import 'package:intl/intl.dart';
import '../dialog_box.dart';

class AnimatedToggle extends ConsumerStatefulWidget {
  final String documentId;
  final String collectionName;
  final DateTime bookedDate;
  const AnimatedToggle(
      {super.key,
      required this.documentId,
      required this.collectionName,
      required this.bookedDate});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends ConsumerState<AnimatedToggle> {
  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<bool>.dual(
      innerColor: const Color(0xff000000),
      current: false /* confirmationController */,
      first: false,
      second: true,
      dif: 200.0,
      borderColor: const Color(0xffD5A218),
      borderWidth: 1.0,
      height: 46,
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          spreadRadius: 1,
          blurRadius: 2,
          offset: Offset(0, 2),
        ),
      ],
      colorBuilder: (b) => Colors.transparent,
      iconBuilder: (value) => value
          ? const CircleAvatar(
              radius: 100,
              backgroundColor: Color(0xffDEAA1B),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            )
          : const CircleAvatar(
              radius: 100,
              backgroundColor: Color(0xffDEAA1B),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
      textBuilder: (value) => value
          ? const Center(
              child: Text(
                'Confirmed',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          : const Center(
              child: Text(
              'Slide to confirm entry',
              style: TextStyle(
                color: Colors.white,
              ),
            )),
      onChanged: (b) async {
        final bookedDate = DateFormat.yMMMd().format(widget.bookedDate);
        final today = DateFormat.yMMMd()
            .format(Timestamp.fromDate(DateTime.now()).toDate());

        final allowedTime =
            widget.bookedDate.subtract(const Duration(minutes: 45));

        if (bookedDate == today) {
          if ((widget.collectionName == "event_entry_bookings" &&
                  allowedTime.isBefore(DateTime.now())) ||
              (widget.collectionName == "club_entry_bookings" ||
                  widget.collectionName == "table_booking")) {
            await updateStatus(widget.documentId, widget.collectionName);
            await Future.delayed(const Duration(seconds: 2));
            ref.read(isCheckedProvider.notifier).state = true;
            if (!mounted) return;
            onToday(context, ref);
          } else {
            notTodaysBooking(context, ref, widget.bookedDate);
          }
        } else {
          notTodaysBooking(context, ref, widget.bookedDate);
        }
      },
    );
  }

  updateStatus(String documentId, String collectionName) async {
    final db = FirebaseFirestore.instance;
    final snapshot = await db.collection(collectionName).doc(documentId).set(
        {"isCheckedIn": true, "status": "Completed"}, SetOptions(merge: true));
    return snapshot;
  }

  onToday(BuildContext context, WidgetRef ref) {
    return showDialog(
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ref.read(dialogBoxProvider).confirmationPopup(
              context, 'done.png', 'Check-in confirmed', '', false);
        },
        context: context);
  }

  notTodaysBooking(
      BuildContext context, WidgetRef ref, DateTime bookingDate) async {
    // Navigator.pop(context);
    final today = DateTime.now();
    final past = bookingDate.isBefore(today);
    final upcoming = bookingDate.isAfter(today);
    return showDialog(
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return ref.read(dialogBoxProvider).confirmationPopup(
              context,
              "denied.png",
              "Entry Access denied",
              past
                  ? "Access is Denied For Past Booking"
                  : upcoming
                      ? "Please wait 45 minutes before \nthe entry time to scan QR code"
                      : "Something went wrong ",
              true);
        },
        context: context);
  }
}
