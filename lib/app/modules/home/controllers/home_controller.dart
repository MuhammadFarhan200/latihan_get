import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latihan_get/app/modules/dashboard/views/dashboard_view.dart';
import 'package:latihan_get/app/modules/login/views/login_view.dart';

class HomeController extends GetxController {
  late Timer _pindah;
  final authToken = GetStorage();

  @override
  void onInit() {
    _pindah = Timer.periodic(
      const Duration(seconds: 3),
      (timer) => authToken.read('token') == null ? Get.off(
        () => const LoginView(),
        transition: Transition.leftToRight,
      ) : Get.off(
        () => const DashboardView(),
        transition: Transition.leftToRight,
      ),
    );
    super.onInit();
  }

  @override
  void onClose() {
    _pindah.cancel();
    super.onClose();
  }
}
