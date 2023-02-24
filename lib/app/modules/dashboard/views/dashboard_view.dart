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
        length: 4,
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
                        ),
                        const SizedBox(height: 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Author: ${snapshot.data!.data![index].author.toString()}'),
                            Text('Sumber: ${snapshot.data!.data![index].name.toString()}'),
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
                        ),
                        const SizedBox(height: 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Author: ${snapshot.data!.data![index].author.toString()}'),
                            Text('Sumber: ${snapshot.data!.data![index].name.toString()}'),
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
                        ),
                        const SizedBox(height: 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Author: ${snapshot.data!.data![index].author.toString()}'),
                            Text('Sumber: ${snapshot.data!.data![index].name.toString()}'),
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
                        ),
                        const SizedBox(height: 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Author: ${snapshot.data!.data![index].author.toString()}'),
                            Text('Sumber: ${snapshot.data!.data![index].name.toString()}'),
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
}
