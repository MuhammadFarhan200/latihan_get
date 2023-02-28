import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_get/app/data/entertaiment_response.dart';
import 'package:latihan_get/app/data/headline_response.dart';
import 'package:latihan_get/app/data/sport_response.dart';
import 'package:latihan_get/app/data/technology_response.dart';
import 'package:lottie/lottie.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    final ScrollController scrollController = ScrollController();

    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    'Hallo',
                    textAlign: TextAlign.end,
                  ),
                  subtitle: Text(
                    controller.auth.read('full_name').toString(),
                    textAlign: TextAlign.end,
                  ),
                  trailing: Container(
                    margin: const EdgeInsets.only(right: 20),
                    width: 50,
                    height: 50,
                    child: Lottie.network(
                      'https://gist.githubusercontent.com/olipiskandar/2095343e6b34255dcfb042166c4a3283/raw/d76e1121a2124640481edcf6e7712130304d6236/praujikom_kucing.json',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.topCenter,
                  child: TabBar(
                    labelColor: Colors.black,
                    dividerColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.white,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Quicksand'),
                    tabs: [
                      Tab(text: "Headline"),
                      Tab(text: "Teknologi"),
                      Tab(text: "Olahraga"),
                      Tab(text: "Hiburan"),
                      Tab(icon: Icon(CupertinoIcons.person_solid)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              headline(controller, scrollController),
              teknologi(controller, scrollController),
              sports(controller, scrollController),
              entertainment(controller, scrollController),
              profile(controller, scrollController),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.logout();
            },
            backgroundColor: Colors.redAccent,
            child: const Icon(Icons.logout_rounded),
          ),
        ),
      ),
    );
  }

  FutureBuilder<HeadlineResponse> headline(DashboardController controller, ScrollController scrollController) {
    return FutureBuilder<HeadlineResponse>(
      future: controller.getHeadline(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LottieBuilder.network(
              'https://assets8.lottiefiles.com/packages/lf20_6jxjxq.json',
              repeat: true,
              width: Get.width / 1,
            ),
          );
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Tidak Ada'));
        }
        return ListView.builder(
          itemCount: snapshot.data!.data!.length,
          controller: scrollController,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 5),
              height: 110,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      snapshot.data!.data![index].urlToImage.toString(),
                      height: 130,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          snapshot.data!.data![index].title.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          snapshot.data!.data![index].publishedAt.toString().substring(0, 10),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Author: ${snapshot.data!.data![index].author.toString()}', 
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            ),
                            Text('Sumber: ${snapshot.data!.data![index].name.toString()}', 
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  FutureBuilder<TechnologyResponse> teknologi(DashboardController controller, ScrollController scrollController) {
    return FutureBuilder<TechnologyResponse>(
      future: controller.getTechnology(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LottieBuilder.network(
              'https://assets8.lottiefiles.com/packages/lf20_6jxjxq.json',
              repeat: true,
              width: Get.width / 1,
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: Text('Tidak Ada'));
        }
        return ListView.builder(
          itemCount: snapshot.data!.data!.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 5),
              height: 110,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      snapshot.data!.data![index].urlToImage.toString(),
                      height: 130,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          snapshot.data!.data![index].title.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          snapshot.data!.data![index].publishedAt.toString().substring(0, 10),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Author: ${snapshot.data!.data![index].author.toString()}', 
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text('Sumber: ${snapshot.data!.data![index].name.toString()}', 
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  FutureBuilder<SportResponse> sports(DashboardController controller, ScrollController scrollController) {
    return FutureBuilder<SportResponse>(
      future: controller.getSport(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LottieBuilder.network(
              'https://assets8.lottiefiles.com/packages/lf20_6jxjxq.json',
              repeat: true,
              width: Get.width / 1,
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: Text('Tidak Ada'));
        }
        return ListView.builder(
          itemCount: snapshot.data!.data!.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 5),
              height: 110,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      snapshot.data!.data![index].urlToImage.toString(),
                      height: 130,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          snapshot.data!.data![index].title.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          snapshot.data!.data![index].publishedAt.toString().substring(0, 10),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Author: ${snapshot.data!.data![index].author.toString()}', 
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text('Sumber: ${snapshot.data!.data![index].name.toString()}', 
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  FutureBuilder<EntertaimentResponse> entertainment(DashboardController controller, ScrollController scrollController) {
    return FutureBuilder<EntertaimentResponse>(
      future: controller.getEntertainment(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LottieBuilder.network(
              'https://assets8.lottiefiles.com/packages/lf20_6jxjxq.json',
              repeat: true,
              width: Get.width / 1,
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: Text('Tidak Ada'));
        }
        return ListView.builder(
          itemCount: snapshot.data!.data!.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 5),
              height: 110,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      snapshot.data!.data![index].urlToImage.toString(),
                      height: 130,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          snapshot.data!.data![index].title.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          snapshot.data!.data![index].publishedAt.toString().substring(0, 10),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Author: ${snapshot.data!.data![index].author.toString()}', 
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1 ,
                            ),
                            Text('Sumber: ${snapshot.data!.data![index].name.toString()}', 
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1 ,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  SingleChildScrollView profile(DashboardController controller, ScrollController scrollController) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                'https://www.hanzzt.me/img/profile.jpg',
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'M Farhan Nasrulloh',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              shadows: CupertinoContextMenu.kEndBoxShadow,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            '@farhannsrllh_',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network('https://cdn-icons-png.flaticon.com/512/2111/2111425.png', height: 35),
              Image.network('https://cdn-icons-png.flaticon.com/512/3059/3059997.png', height: 35),
              Image.network('https://cdn-icons-png.flaticon.com/512/733/733579.png', height: 35),
            ],
          ),
          const SizedBox(height: 25),
          const Text(
            'About',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              shadows: CupertinoContextMenu.kEndBoxShadow,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Hello, introduce my name is Muhammad Farhan Nasrulloh. I am a student at SMK Assalaam Bandung who is currently learning web programming. For now I already have fundamental knowledge about several programming languages and several frameworks likes PHP, HTML, CSS, Javascript, Bootstrap, Laravel, Flutter, etc.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
