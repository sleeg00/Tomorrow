import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tomorrow/screen/start.dart';

Future<bool> getToken() async {
  //Token있는지 확인
  const storage = FlutterSecureStorage();
  String? a = await storage.read(key: 'accessToken');
  String? b = await storage.read(key: 'refreshToken');
  if (a != null && b != null) {
    return false;
  } else {
    return true;
  }
}

Future<void> createMember(String sex, String year) async {
  final response = await http.post(
    Uri.parse('http://localhost:8081/api/member/join'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'sex': sex,
      'year': year,
    }),
  );
  if (response.statusCode == 200) {
    const storage = FlutterSecureStorage();
    Map<String, String> m = response.headers;

    await storage.deleteAll();
    await storage.write(key: 'accessToken', value: m['accesstoken']);
    await storage.write(key: 'refreshToken', value: m['refreshtoken']);
  } else {
    print("error");
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

class Join extends StatefulWidget {
  const Join({super.key});

  @override
  State<Join> createState() => _JoinState();
}

class _JoinState extends State<Join> {
  String selectedDropdown = "중성";

  List<String> yearList = [];

  String selectedYear = "2023";
  String startMessage = "회원가입 하겠습니까?";
  @override
  void initState() {
    super.initState();
    for (int i = 1900; i <= 2023; i++) {
      yearList.add(i.toString());
    }
    getToken().then((value) {
      if (value == true) {
        errorJoin();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int k = 0;
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
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 0,
                          width: 30,
                        ),
                        const Text(
                          "성별을 선택해주세요!",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        DropdownButton(
                          value: selectedDropdown,
                          items: const [
                            //add items in the dropdown
                            DropdownMenuItem(
                              value: "남자",
                              child: Text("남자"),
                            ),
                            DropdownMenuItem(
                              value: "여자",
                              child: Text("여자"),
                            ),
                            DropdownMenuItem(
                              value: "중성",
                              child: Text("중성"),
                            )
                          ],
                          onChanged: (dynamic value) {
                            //get value when changed
                            setState(() {
                              selectedDropdown = value;
                            });
                          },

                          iconSize: 0.0,
                          style: const TextStyle(
                            color:
                                Color.fromARGB(255, 249, 250, 249), //Font color
                            fontSize: 30, //font size on dropdown button
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.transparent,
                          ),

                          dropdownColor:
                              Colors.transparent, //dropdown background color
                          underline: Container(),
                          menuMaxHeight: 400, //remove underline
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 120,
                  ),
                  Column(
                    children: [
                      const Center(
                        child: Text(
                          "태어난 년도를 선택해주세요!",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      DropdownButton(
                        value: selectedYear,
                        items: yearList
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (dynamic value) {
                          setState(() {
                            selectedYear = value;
                          });
                        },

                        iconSize: 0.0,
                        style: const TextStyle(
                            //te
                            color: Colors.white, //Font color
                            fontSize: 30, //font size on dropdown button
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.transparent),
                        iconDisabledColor: Colors.red,

                        iconEnabledColor: Colors.blue,
                        dropdownColor:
                            Colors.transparent, //dropdown background color
                        underline: Container(), //
                        menuMaxHeight: 400,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 250,
            ),
            IconButton(
              color: const Color.fromARGB(255, 219, 46, 249),
              icon: const Icon(Icons.rocket_launch),
              onPressed: () {
                doubleCheck();
              },
              iconSize: 70,
            ),
          ],
        ),
      ),
    );
  }

  void doubleCheck() {
    showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        builder: (BuildContext ctx) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            alignment: Alignment.center,
            title: Center(
              child: Text(
                startMessage,
                style: const TextStyle(
                  color: Color.fromARGB(255, 6, 6, 6),
                  fontSize: 25,
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 219, 46, 249),
                ),
                onPressed: () {
                  getToken().then((value) {
                    createMember(selectedDropdown, selectedYear);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Start()),
                    );
                    /*
                    else {
                      errorJoin();
                    }
                    */
                  });
                },
                child: const Text(
                  "예",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 219, 46, 249),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "아니요",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          );
        });
  }

  void errorJoin() {
    showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        builder: (BuildContext ctx) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            alignment: Alignment.center,
            title: const Center(
              child: Text(
                '이미 아이디가 존재합니다',
                style: TextStyle(
                  color: Color.fromARGB(255, 6, 6, 6),
                  fontSize: 25,
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 219, 46, 249),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Start()),
                  );
                },
                child: const Text(
                  "원래 페이지로 가기",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
