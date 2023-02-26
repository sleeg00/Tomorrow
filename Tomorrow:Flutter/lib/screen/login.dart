import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:tomorrow/screen/start.dart';

import 'join.dart';

Future<Map<String, String>> getToken() async {
  const storage = FlutterSecureStorage();
  Map<String, String> allValues = await storage.readAll();
  return allValues;
}

Future<int> loginMember(
    String id, String pw, String accessToken, String refreshToken) async {
  print('accessToken : $accessToken');
  print('refreshToken: $refreshToken');
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
    return response.statusCode;
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
  Future<int>? goStart;
  Future<Map<String, String>>? m;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/join.png'), // 배경 이미지
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FittedBox(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      getToken().then((value) {
                        loginMember(tecId.text, tecPw.text,
                                value['accessToken']!, value['refreshToken']!)
                            .then((value) {
                          if (value == 200) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Start(),
                              ),
                            );
                          }
                        }).catchError((error) {
                          print('loginMember error: $error');
                        });
                      }).catchError((error) {
                        print('getToken error: $error');
                      });
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
