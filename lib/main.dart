import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  runApp(
     GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Quicksand',
      ),
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      defaultTransition: Transition.leftToRight,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
