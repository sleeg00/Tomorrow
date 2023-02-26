import 'package:flutter/material.dart';
import 'package:tomorrow/Service/infiniteScroll.dart';
import 'dart:math';

import 'package:tomorrow/screen/post.dart';

import '../Model/my_flutter_app_icons.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    int random = Random().nextInt(6) + 1;
    return MaterialApp(
      title: 'Tomorrow',
      home: Scaffold(
        resizeToAvoidBottomInset: false, // 키보드가 올라와도 배경 이미지가 밀려 올라가지 않도록
        appBar: AppBar(
          key: key,
          backgroundColor: Colors.transparent,
          title: const Text('Tomorrow'),
          titleTextStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255), fontSize: 24),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                color: const Color.fromARGB(255, 253, 253, 253),
                icon: const Icon(Icons.menu),
                iconSize: 30,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: [
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  color: const Color.fromARGB(255, 253, 253, 253),
                  icon: const Icon(MyFlutterApp.attach_file),
                  iconSize: 30,
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                );
              },
            ),
          ],
        ),
        drawer: const Menu(),
        endDrawer: const Menu(),
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/join.png'), // 배경 이미지
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(0, 238, 6, 6),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  size: 35,
                  MyFlutterApp.home,
                  color: Color.fromARGB(200, 249, 246, 246),
                ),
                label: "",
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
              icon: Icon(
                size: 35,
                MyFlutterApp.user,
                color: Colors.white,
              ),
              label: '',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(icon: Icon(MyFlutterApp.home), label: 'my')
          ],
          onTap: (value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Post(),
              ),
            );
          },
        ),
        extendBody: true,
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 12, 12, 12),
      //메뉴 나타내기

      child: ListView(
        padding: EdgeInsets.zero, //여백 x
        // padding: const EdgeInsets.only(left: 150),
        children: [
          const SizedBox(
            height: 100,
          ),
          /*
          ListTile(
            leading: const Icon(
              size: 35,
              MyFlutterApp.menu_alert_icon,
              color: Color.fromARGB(255, 237, 240, 242),
            ),
            title: const Text(
              '알림',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 237, 240, 242),
              ),
            ),
            onTap: () {
              print("알림");
            },
          ),
          */
          ListTile(
            leading: const Icon(
              size: 35,
              MyFlutterApp.account_circle,
              color: Color.fromARGB(255, 246, 247, 248),
            ),
            title: const Text(
              '글 쓰기',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 237, 240, 242),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Post(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              size: 35,
              Icons.menu_book_sharp,
              color: Color.fromARGB(255, 246, 247, 248),
            ),
            title: const Text(
              '내가 쓴 글',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 237, 240, 242),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InfiniteScrollPaginatorDemo(),
                ),
              );
            },
          ),
          /*
          ListTile(
            leading: const Icon(
              size: 35,
              MyFlutterApp.visibility,
              color: Color.fromARGB(255, 247, 248, 249),
            ),
            title: const Text(
              '팔로워',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 237, 240, 242),
              ),
            ),
            onTap: () {
              print('Settings');
            },
          ),
          ListTile(
            leading: const Icon(
              size: 35,
              Icons.settings,
              color: Color.fromARGB(255, 237, 245, 246),
            ),
            title: const Text(
              '',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              print('Settings');
            },
          ),
          ListTile(
            leading: const Icon(
              size: 35,
              Icons.settings,
              color: Color.fromARGB(255, 243, 245, 247),
            ),
            title: const Text(
              '설정',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 237, 240, 242),
              ),
            ),
            onTap: () {
              print('Settings');
            },
          ),
          */
        ],
      ),
    );
  }
}
