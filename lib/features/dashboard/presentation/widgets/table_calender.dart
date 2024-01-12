import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

// ignore: must_be_immutable
class TableCalenderWidget extends ConsumerWidget {
  final DateTime firstDay;
  final DateTime lastDay, selectedDateController;
  void Function(DateTime, DateTime)? onDaySelected;

  TableCalenderWidget(
      {super.key,
      required this.firstDay,
      required this.lastDay,
      required this.selectedDateController,
      required this.onDaySelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TableCalendar(
      headerVisible: false,
      daysOfWeekVisible: false,
      calendarFormat: CalendarFormat.week,
      firstDay: firstDay,
      lastDay: lastDay,
      focusedDay: selectedDateController,
      headerStyle: const HeaderStyle(
          titleTextStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      calendarStyle: const CalendarStyle(
          isTodayHighlighted: false,
          weekendTextStyle:
              TextStyle(color: Color.fromARGB(255, 253, 250, 145)),
          selectedDecoration: BoxDecoration(
              color: Color(0xffD79800), shape: BoxShape.rectangle),
          todayDecoration: BoxDecoration(
              color: Color(0xffD79800), shape: BoxShape.rectangle)),
      onDaySelected: onDaySelected,
      selectedDayPredicate: (day) => isSameDay(day, selectedDateController),
    );
  }
}
