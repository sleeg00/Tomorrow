import 'package:flutter/material.dart';

import 'join.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
            const TextField(
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                border: InputBorder.none, //테두리 없애기 & 배경색 입히기

                focusedBorder: UnderlineInputBorder(
                  //클릭시 보이게
                  borderSide: BorderSide(color: Colors.white),
                ),

                hintText: '등록하고자하는 Id를 입력하세요!',
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
            const TextField(
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),

              decoration: InputDecoration(
                border: InputBorder.none, //테두리 없애기 & 배경색 입히기
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),

                //테두리 없애기 & 배경색 입히기
                hintText: '등록하고자하는 Pw를 입력하세요!',
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
