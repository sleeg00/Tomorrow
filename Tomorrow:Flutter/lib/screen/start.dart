import 'package:flutter/material.dart';
import 'dart:math';

import 'package:tomorrow/screen/post.dart';

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
          backgroundColor: Colors.white,
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
              Icons.person_pin_circle_rounded,
              color: Colors.grey[850],
            ),
            title: const Text(
              '내 정보',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              print('home!');
            },
          ),
          ListTile(
            leading: Icon(
              size: 35,
              Icons.menu_book_sharp,
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
          )
        ],
      ),
    );
  }
}
