import 'dart:convert';

import 'package:get/get.dart';
import 'package:latihan_get/app/data/entertaiment_response.dart';
import 'package:latihan_get/app/data/sport_response.dart';
import 'package:latihan_get/app/data/technology_response.dart';

import '../../../data/headline_response.dart';
import '../../../utils/api.dart';

class DashboardController extends GetxController {
  final getConnect = GetConnect();
  
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
}
