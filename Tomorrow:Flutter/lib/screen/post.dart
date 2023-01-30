import 'package:flutter/material.dart';
import 'package:tomorrow/screen/start.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/login.png'), // 배경 이미지
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent, //->배경화면 안 바뀌게 상황에 따라?
          endDrawer: const Menu(),
          resizeToAvoidBottomInset: false,
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
          body: Column(
            children: const [
              Padding(
                padding: EdgeInsets.all(70),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
