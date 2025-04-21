import 'dart:developer';

import 'package:fanar/core/network/api_constants.dart';
import 'package:fanar/core/network/custom_http_client.dart';
import 'package:fanar/core/network/no_internet_connection_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkStatusController extends GetxController {
  static NetworkStatusController to = Get.find();

  CustomHttpClient httpClient = CustomHttpClient();

  final Stream<InternetStatus> networkStream =
      InternetConnection().onStatusChange;

  void test() async {
    final serverError = await checkServer();
    if (!serverError) {
      showNoNetworkDialog();
      return;
    }
    networkStream.listen(checkConnection);
  }

  Future<bool> checkServer() async {
    late int? statusCode;
    await httpClient.request(
      url: ApiConstants.ping,
      onSuccess: (response) {
        statusCode = response.statusCode;
      },
      onError: (error) {
        statusCode = error.response?.statusCode;
      },
      showResult: true,
    );

    return statusCode == 200;
  }

  void checkConnection(InternetStatus event) {
    log('connection has been checked');
    switch (event) {
      case InternetStatus.connected:
        removeCurrentDialog();
        break;
      case InternetStatus.disconnected:
        showNoNetworkDialog();
    }
  }

  void showNoNetworkDialog() {
    removeCurrentDialog();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Get.dialog(
          NoInternetConnectionDialog(),
          barrierDismissible: false,
        );
      },
    );
  }

  void removeCurrentDialog() {
    if (Get.isDialogOpen ?? false) Get.back(closeOverlays: true);
  }
}
