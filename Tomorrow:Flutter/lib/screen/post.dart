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

Future<int> write(String content, String title, String emoticon,
    String accessToken, String refreshToken) async {
  final response = await http.post(
    Uri.parse('http://localhost:8081/api/post/write'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    },
    body: jsonEncode(<String, dynamic>{
      'content': content,
      'title': title,
      'emoticon': emoticon,
    }),
  );

  if (response.statusCode == 200) {
    const storage = FlutterSecureStorage();
    Map<String, String> m = response.headers;
    if (m['accesstoken'] != null) {
      print("accesstoken 존재");
      await storage.delete(key: 'accessToken');
      await storage.write(key: 'accessToken', value: m['accesstoken']);
    }
    return response.statusCode;
  } else {
    print("${response.statusCode}");
    return 400;
  }
}

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  get key => null;

  final iconList = [
    MyFlutterApp.emo_angry,
    MyFlutterApp.emo_coffee,
    MyFlutterApp.emo_happy,
    MyFlutterApp.emo_sleep,
    MyFlutterApp.emo_surprised,
    MyFlutterApp.emo_thumbsup,
    MyFlutterApp.emo_tongue,
    MyFlutterApp.emo_unhappy,
    MyFlutterApp.emo_wink,
  ];
  IconData? selecticon;

  @override
  void initState() {
    super.initState();
    setState(() {
      selecticon = iconList[0];
    });
  }

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
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      flex: 20,
                      child: TextField(
                        controller: title,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          labelText: '게시글 제목',

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
                    ),
                    Flexible(
                      flex: 2,
                      child: DropdownButton(
                        dropdownColor: const Color.fromARGB(255, 184, 207, 226),
                        value: selecticon,
                        icon: const SizedBox.shrink(),
                        underline: Container(), //remove underline
                        items: iconList
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Icon(e),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selecticon = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: content,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: '게시글 내용',
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
                      write(content.text, title.text, selecticon.toString(),
                              value['accessToken']!, value['refreshToken']!)
                          .then((value) {
                        if (value == 200) {
                          print("성공!");
                        }
                      }).catchError((error) {
                        print('write: $error');
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
