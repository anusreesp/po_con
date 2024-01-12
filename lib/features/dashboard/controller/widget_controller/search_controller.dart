import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// int idVal = 0;
// final searchIdProvider = StateProvider<int>((ref) {
//   return idVal;
// });

final nameSearchProvider = StateProvider<String>((ref) {
  return "";
});

final newNameSearchProvider = StateProvider<String>((ref) {
  return "";
});

final pastNameSearchProvider = StateProvider<String>((ref) {
  return "";
});

final TextEditingController _editinghomeController = TextEditingController();
final homeControllerProvider = StateProvider<TextEditingController>((ref) {
  return _editinghomeController;
});

final TextEditingController _editingupcomingController =
    TextEditingController();
final upcomingControllerProvider = StateProvider<TextEditingController>((ref) {
  return _editingupcomingController;
});

final TextEditingController _editingpastController = TextEditingController();
final pastControllerProvider = StateProvider<TextEditingController>((ref) {
  return _editingpastController;
});

// BookingCloudData data;
