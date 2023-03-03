import 'package:flutter/material.dart';
import 'package:tomorrow/Service/infiniteScroll.dart';
import 'dart:math';

import 'package:tomorrow/screen/post.dart';

import '../Model/my_flutter_app_icons.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  int selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const InfiniteScrollPaginatorDemo(),
        ),
      );
    }
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Post()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int random = Random().nextInt(6) + 1;
    return MaterialApp(
      title: 'Tomorrow',
      home: Scaffold(
        resizeToAvoidBottomInset: false, // 키보드가 올라와도 배경 이미지가 밀려 올라가지 않도록
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Tomorrow'),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
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
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 35,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                MyFlutterApp.search,
                size: 35,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                MyFlutterApp.rocket,
                size: 35,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.alarm,
                size: 35,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                MyFlutterApp.user,
                size: 35,
              ),
              label: '',
            ),
          ],
          currentIndex: selectedIndex,
          unselectedItemColor:
              const Color.fromARGB(255, 252, 251, 251).withOpacity(0.8),
          selectedItemColor:
              const Color.fromARGB(255, 200, 200, 200).withOpacity(0.8),
          onTap: _onItemTapped,
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
        children: [
          const SizedBox(
            height: 100,
          ),
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
        ],
      ),
    );
  }
}
