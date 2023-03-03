import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tomorrow/screen/start.dart';

import 'join.dart';

Future<bool> getToken() async {
  const storage = FlutterSecureStorage();
  String? a = await storage.read(key: 'accessToken');
  String? b = await storage.read(key: 'refreshToken');
  if (a != null && b != null) {
    return false;
  } else {
    return true;
  }
}

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
                  getToken().then((value) {
                    if (value == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Join(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Start(),
                        ),
                      );
                    }
                  });
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
