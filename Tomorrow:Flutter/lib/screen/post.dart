import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:tomorrow/screen/start.dart';

import '../my_flutter_app_icons.dart';

Future<Map<String, String>> getToken() async {
  const storage = FlutterSecureStorage();
  Map<String, String> allValues = await storage.readAll();
  return allValues;
}

Future<int> write(String content, String title, String accessToken,
    String refreshToken) async {
  final response = await http.post(
    Uri.parse('http://localhost:8081/api/post/write'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    },
    body: jsonEncode(<String, String>{
      'content': content,
      'title': title,
    }),
  );
  if (response.statusCode == 200) {
    const storage = FlutterSecureStorage();
    Map<String, String> m = response.headers;
    await storage.write(key: 'accessToken', value: m['accesstoken']);
    await storage.write(key: 'refreshToken', value: m['refreshtoken']);
    return response.statusCode;
  } else {
    print("error");
    return response.statusCode;
  }
}

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController content = TextEditingController();
    TextEditingController title = TextEditingController();
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
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: title,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'title',
                    border: InputBorder.none,
                    // counter text를 비움으로 설정
                  ),
                  maxLength: 12,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextField(
                  controller: content,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'content',
                    counterText: '', // counter text를 비움으로 설정
                  ),
                  maxLength: 100,
                  maxLines: 15,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    getToken().then((value) {
                      write(content.text, title.text, value['accessToken']!,
                              value['refreshToken']!)
                          .then((value) {
                        if (value == 200) {
                          print("성공!");
                        }
                      }).catchError((error) {
                        print('write error: $error');
                      });
                    }).catchError((error) {
                      print('getToken error: $error');
                    });
                  },
                  icon: const Icon(MyFlutterApp.pencil, size: 50),
                ),
              ],
            ),
          )),
    );
  }
}
