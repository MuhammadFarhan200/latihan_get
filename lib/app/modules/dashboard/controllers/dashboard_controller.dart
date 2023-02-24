import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/headline_response.dart';
import '../../../utils/api.dart';

class DashboardController extends GetxController {
  
  Future<List<HeadlineResponse>> getHeadline() async {
    final response = await http.get(Uri.https(BaseUrl.headline));
    return json.decode(response.body)['data'];
  }
}
