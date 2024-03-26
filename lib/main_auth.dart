import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:uddipan/app/modules/login/views/login_view.dart';
import 'package:uddipan/constants/string_constant.dart';

import 'app/modules/bottom_navigation_bar/view/bottom_navigation_bar_view.dart';

class MainAuth extends StatelessWidget {
  const MainAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: getToken(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null) {
            return const LoginView();
          }
          if (snapshot.data!.isNotEmpty) {
            return BottomNavigationBarView(
              routeIndex: 0,
            );
          } else {
            return const LoginView();
          }
        });
  }
}

Future<String?> getToken() async {
  String? token = getbox.read(userToken);
  print('token ${token}');
  if (token == null) {
    return null;
  } else {
    return token;
  }
}
