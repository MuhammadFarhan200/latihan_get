import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latihan_get/app/data/entertaiment_response.dart';
import 'package:latihan_get/app/data/sport_response.dart';
import 'package:latihan_get/app/data/technology_response.dart';
import 'package:latihan_get/app/modules/home/views/home_view.dart';

import '../../../data/headline_response.dart';
import '../../../utils/api.dart';

class DashboardController extends GetxController {
  final getConnect = GetConnect();
  final auth = GetStorage();
  
  Future<HeadlineResponse> getHeadline() async {
    final response = await getConnect.get(BaseUrl.headline);
    return HeadlineResponse.fromJson(jsonDecode(response.body));
  }

  Future<TechnologyResponse> getTechnology() async {
    final response = await getConnect.get(BaseUrl.technology);
    return TechnologyResponse.fromJson(jsonDecode(response.body));
  }

  Future<SportResponse> getSport() async {
    final response = await getConnect.get(BaseUrl.sports);
    return SportResponse.fromJson(jsonDecode(response.body));
  }

  Future<EntertaimentResponse> getEntertainment() async {
    final response = await getConnect.get(BaseUrl.entertainment);
    return EntertaimentResponse.fromJson(jsonDecode(response.body));
  }

  void logout() async {
    await Get.defaultDialog(
      title: 'Logout',
      middleText: 'Anda yakin akan logout?',
      textConfirm: 'Logout',
      textCancel: 'Batal',
      titlePadding: const EdgeInsets.only(top: 20),
      contentPadding: const EdgeInsets.only(top: 10, bottom: 20),
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.blue,
      buttonColor: Colors.blue,
      onCancel: () {
        Get.back();
      },
      onConfirm: () {
        auth.erase();
        Get.offAll(() => const HomeView());
      },
    );
  }
}
