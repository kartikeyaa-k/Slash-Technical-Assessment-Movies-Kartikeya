import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:slash_assignment_movies/src/core/utils/app_responsive.dart';
import 'package:slash_assignment_movies/src/core/utils/constants.dart';
import 'package:slash_assignment_movies/src/core/utils/text_constants.dart';

class WelcomeView extends HookWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    navigateToLogin() async {
      Navigator.of(context).pushNamed('login');
    }

    // Need to put this in one place and call init instead using it all view files
    // Short on time
    final Function wp = ScreenUtils(MediaQuery.of(context)).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context)).hp;
    final Function fontSize = ScreenUtils(MediaQuery.of(context)).getFontSize;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(hp(2)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: wp(30),
                        child: Image.asset(
                          kLogoPath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        kWelcomeString,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: fontSize(30),
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(
                        height: hp(20),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            navigateToLogin();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(hp(2)),
                            child: Text(
                              kGettingStart,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: fontSize(22),
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
