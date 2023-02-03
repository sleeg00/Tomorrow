import 'package:flutter/material.dart';
import 'dart:math';

import 'package:tomorrow/screen/post.dart';

import '../my_flutter_app_icons.dart';
import 'mywrite.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    int random = Random().nextInt(6) + 1;
    return MaterialApp(
      title: 'Tomorrow',
      home: Scaffold(
        endDrawer: const Menu(),
        resizeToAvoidBottomInset: false, // 키보드가 올라와도 배경 이미지가 밀려 올라가지 않도록
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
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/login.png'), // 배경 이미지
            ),
          ),
        ),
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
      backgroundColor: Colors.white,
      //메뉴 나타내기
      child: ListView(
        padding: EdgeInsets.zero, //여백 x
        // padding: const EdgeInsets.only(left: 150),
        children: [
          const SizedBox(
            height: 100,
          ),
          ListTile(
            leading: Icon(
              size: 35,
              MyFlutterApp.menu_alert_icon,
              color: Colors.grey[850],
            ),
            title: const Text(
              '알림',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              print("알림");
            },
          ),
          ListTile(
            leading: Icon(
              size: 35,
              MyFlutterApp.pencil,
              color: Colors.grey[850],
            ),
            title: const Text(
              '글 쓰기',
              style: TextStyle(fontSize: 18),
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
            leading: Icon(
              size: 35,
              Icons.menu_book_sharp,
              color: Colors.grey[850],
            ),
            title: const Text(
              '내가 쓴 글',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyWrite(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              size: 35,
              MyFlutterApp.visibility,
              color: Colors.grey[850],
            ),
            title: const Text(
              '팔로워',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              print('Settings');
            },
          ),
          ListTile(
            leading: Icon(
              size: 35,
              Icons.settings,
              color: Colors.grey[850],
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
            leading: Icon(
              size: 35,
              Icons.settings,
              color: Colors.grey[850],
            ),
            title: const Text(
              '설정',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              print('Settings');
            },
          ),
        ],
      ),
    );
  }
}
