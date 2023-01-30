import 'package:flutter/material.dart';

import 'login.dart';

class Write extends StatelessWidget {
  const Write({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/join.png'), // 배경 이미지
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          /*
          SizedBox(
            height: 100,
            width: 200,
            child: FittedBox(
              child: FloatingActionButton.extended(
                heroTag: "JoinButton", //FAB가 두 개 이상이면 필수 아니면 충돌 오류
                //extended=Custom할 수 있다
                shape: const RoundedRectangleBorder(),
                backgroundColor:
                    const Color.fromARGB(255, 119, 73, 13).withOpacity(0.1),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Join(),
                    ),
                  );
                },
                label: const Text(
                  'Join ',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          */
          const SizedBox(
            height: 100,
          ),
          SizedBox(
            height: 100,
            width: 200,
            child: FittedBox(
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                },
                child: const Text(
                  'Start',
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
