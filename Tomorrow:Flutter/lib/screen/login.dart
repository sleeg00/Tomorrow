import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import 'join.dart';

Future<Map<String, String>> searchToken() async {
  const storage = FlutterSecureStorage();
  Map<String, String> allValues = await storage.readAll();
  return allValues;
}

Future<void> loginMember(
    String id, String pw, String accessToken, String refreshToken) async {
  print('accessToken =');
  print(accessToken);
  final response = await http.post(
    Uri.parse('http://localhost:8081/api/member/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    },
    body: jsonEncode(<String, String>{
      'id': id,
      'pw': pw,
    }),
  );
  const storage = FlutterSecureStorage();
  Map<String, String> m = response.headers;
  if (m['accesstoken'] != null) {
    await storage.delete(key: 'accessToken');
    await storage.write(key: 'accessToken', value: m['accesstoken']);
    print('accessToken:!!!!');
    print(m['accesstoken']);
  }
}

class Member {
  final String id;
  final String pw;

  const Member({required this.id, required this.pw});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      pw: json['pw'],
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController tecId = TextEditingController();
  TextEditingController tecPw = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/write1.png'), // 배경 이미지
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
              width: 200,
            ),
            TextField(
              controller: tecId,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none, //테두리 없애기 & 배경색 입히기

                focusedBorder: UnderlineInputBorder(
                  //클릭시 보이게
                  borderSide: BorderSide(color: Colors.white),
                ),

                hintText: '로그인하고자하는 Id를 입력하세요!',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
                labelText: 'Username',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            const SizedBox(height: 50),
            TextField(
              controller: tecPw,
              style: const TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),

              decoration: const InputDecoration(
                border: InputBorder.none, //테두리 없애기 & 배경색 입히기
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),

                //테두리 없애기 & 배경색 입히기
                hintText: '로그인하고자하는 Pw를 입력하세요!',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
                labelText: 'PassWord',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              obscureText: true, //비밀번호 가리기
            ),
            const SizedBox(
              height: 500,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FittedBox(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      searchToken().then((value) => setState(() {
                            loginMember(tecId.text, tecPw.text,
                                value['accessToken']!, value['refreshToken']!);
                          }));
                    },
                    child: const Text(
                      '로그인',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 232, 216, 216)),
                    ),
                  ),
                ),
                FittedBox(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Join(),
                        ),
                      );
                    },
                    child: const Text(
                      '회원가입',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 232, 216, 216)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
