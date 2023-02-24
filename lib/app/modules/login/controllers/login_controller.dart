import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latihan_get/app/modules/dashboard/views/dashboard_view.dart';
import 'package:latihan_get/app/modules/login/views/login_view.dart';
import 'package:latihan_get/app/utils/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final authToken = GetStorage();
   final isLoading = false.obs;

  void loginNow() async {
    isLoading.value = true;
    var client = http.Client();
    var response = await client.post(
      Uri.https(BaseUrl.auth, '/api/login'),
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );

    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    if (decodedResponse['success'] == true) {
      isLoading.value = false;
      authToken.write('token', decodedResponse['access_token']);
      Get.offAll(() => const DashboardView());
    } else {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        decodedResponse['message'].toString(),
        icon: const Icon(Icons.error),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        forwardAnimationCurve: Curves.bounceIn,
        margin: const EdgeInsets.only(
          top: 10,
          left: 5,
          right: 5,
        ),
      );
    }
  }

    void logout() {
    authToken.remove('token');
    Get.offAll(() => const LoginView());
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
