part of 'connectivity_controller.dart';

abstract class ConnectivityState {}

class ConnectivityNone extends ConnectivityState {}

class ConnectivityLoading extends ConnectivityState {}

class ConnectivityLoaded extends ConnectivityState {}
