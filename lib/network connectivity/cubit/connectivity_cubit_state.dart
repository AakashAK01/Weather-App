part of 'connectivity_cubit_cubit.dart';

@immutable
abstract class ConnectivityState {}

class ConnectivityConnected extends ConnectivityState {}

class ConnectivityDisconnected extends ConnectivityState {}

class ConnectivityLoading extends ConnectivityState {}
