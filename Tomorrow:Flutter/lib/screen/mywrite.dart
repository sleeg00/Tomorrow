/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomorrow/my_scroll_controller.dart';

class MyWrite extends StatelessWidget {
  final controller = Get.put<MyScrollController>(MyScrollController());

  MyWrite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: key,
        backgroundColor: const Color.fromARGB(255, 102, 144, 227),
        title: const Text('Tomorrow'),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 24),
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                color: Colors.grey[800],
                icon: const Icon(Icons.menu),
                iconSize: 30,
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.separated(
            controller: controller.scrollController.value,
            separatorBuilder: (_, index) => const Divider(),
            itemCount: controller.data.length + 1, //데이터 길이
            itemBuilder: (_, index) {
              print(controller.data.length + 1);
              if (index < controller.data.length) {
                var datum = controller.data[index];
                return Material(
                  elevation: 10.0,
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: ListTile(
                      leading: const Icon(Icons.android_sharp),
                      title: Text('$datum 번째 데이터'),
                      trailing: const Icon(Icons.arrow_forward_outlined),
                    ),
                  ),
                );
              }
              if (controller.hasMore.value || controller.isLoading.value) {
                return const Center(child: RefreshProgressIndicator());
              }
              return Container(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    children: const [
                      Text('데이터의 마지막 입니다'),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => AnimatedContainer(
            decoration: const BoxDecoration(
              color: Colors.lightBlue,
            ),
            curve: Curves.fastLinearToSlowEaseIn,
            duration: const Duration(milliseconds: 200),
            height: controller.isShow.value ? 60 : 0,
            child: Container(
              child: const Center(
                  child: Text(
                'BottomNavigationBar',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
          )),
    );
  }
}

*/