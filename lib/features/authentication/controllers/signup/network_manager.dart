import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_app/features/authentication/controllers/signup/loaders.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize the network manager and set up a stream to continuously check the connection status
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        _updateConnectionStatus(
            results.isNotEmpty ? results.last : ConnectivityResult.none);
      },
    );
  }

  // Update the connection status based on changes in connectivity and show a relevant popup message for no internet connection
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    if (_connectionStatus.value == ConnectivityResult.none) {
      Loaders.warningSnackBar(title: 'No internet connection');
    }
  }

  // Check the internet connection status
  // Return 'true' if connected, 'false' otherwise
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } on PlatformException catch (_) {
      return false;
    }
  }

  // Dispose or close the active connectivity stream
  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
