import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../logger.dart';

part 'connectivity_cubit_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity? connectivity;
  StreamSubscription? internetConnectivityStream;

  ConnectivityCubit({required this.connectivity})
      : super(ConnectivityLoading()) {
    monitorConnection();
  }

  void monitorConnection() {
    internetConnectivityStream =
        connectivity!.onConnectivityChanged.listen((connection) async {
      logger.i(connection.name);
      if (connection == ConnectivityResult.none) {
        emit(ConnectivityDisconnected());
      } else if (connection == ConnectivityResult.mobile ||
          connection == ConnectivityResult.wifi) {
        emit(ConnectivityConnected());
      }
    });
  }

  @override
  Future<void> close() async {
    internetConnectivityStream!.cancel();
    return super.close();
  }
}
