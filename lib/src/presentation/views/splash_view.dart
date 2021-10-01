import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:slash_assignment_movies/src/core/utils/app_responsive.dart';
import 'package:slash_assignment_movies/src/core/utils/constants.dart';

class SplashView extends HookWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void navigateCall() async {
      // Call to Logic which load all app data goes here
      // Faking it 5 seconds delay
      await Future.delayed(const Duration(seconds: 4), () {
        Navigator.of(context).pushNamed('welcome');
      });
    }

    useEffect(() {
      navigateCall();
    }, const []);

    // Need to put this in one place and call init instead using it all view files
    // Short on time

    final Function wp = ScreenUtils(MediaQuery.of(context)).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context)).hp;
    final Function fontSize = ScreenUtils(MediaQuery.of(context)).getFontSize;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(hp(2)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: wp(30),
                child: Image.asset(
                  kLogoPath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: hp(3),
            ),
            Padding(
              padding: EdgeInsets.all(hp(10)),
              child: const LinearProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
