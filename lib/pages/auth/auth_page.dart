import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';
import '../../utils/images.dart';
import 'widgets/sign_in_widget.dart';

class AuthPage extends StatefulWidget {
  final int initialPage;
  const AuthPage({Key? key, this.initialPage = 0}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoginPage = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            Images.background,
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: Dimensions.topSpace),
                Image.asset(Images.logoPjg, height: 150, width: 300),
                const SizedBox(height: 8),
                const Expanded(
                  child: SignInWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
