import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slash_assignment_movies/src/core/utils/app_responsive.dart';
import 'package:slash_assignment_movies/src/core/utils/constants.dart';
import 'package:slash_assignment_movies/src/core/utils/text_constants.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailCntrl = TextEditingController();
  TextEditingController passCntrl = TextEditingController();

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Need to put this in one place and call init instead using it all view files
    // Short on time

    final Function wp = ScreenUtils(MediaQuery.of(context)).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context)).hp;
    final Function fontSize = ScreenUtils(MediaQuery.of(context)).getFontSize;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: hp(100),
          padding: EdgeInsets.all(hp(2)),
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
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 70,
                child: Column(
                  children: [
                    SizedBox(
                      height: hp(3),
                    ),
                    Container(
                      alignment: AlignmentDirectional.center,
                      padding: EdgeInsets.only(left: hp(2), right: hp(2)),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailCntrl,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(15),
                              ],
                              textAlign: TextAlign.left,
                              enabled: true,
                              keyboardType: TextInputType.name,
                              validator: (String? val) {
                                if (val!.isEmpty) {
                                  return 'Please put any username';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: wp(6), right: wp(6)),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF6c5fe0),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                ),
                                hintText: kUserName,
                              ),
                            ),
                            SizedBox(
                              height: hp(2),
                            ),
                            TextFormField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              controller: passCntrl,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(15),
                              ],
                              textAlign: TextAlign.left,
                              enabled: true,
                              validator: (String? val) {
                                if (val!.isEmpty) {
                                  return 'Please put any password';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: wp(6), right: wp(6)),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF6c5fe0),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                ),
                                hintText: kPassword,
                              ),
                            ),
                            SizedBox(
                              height: hp(5),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

                                  const snackBar = SnackBar(
                                    content: Text(
                                      'Login Successful',
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Navigator.of(context).pushNamed('movie');
                                } else {
                                  const snackBar = SnackBar(
                                    content: Text(
                                      'Incorrect username or password',
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(hp(2)),
                                child: Text(
                                  kLogin..toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: fontSize(22),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
