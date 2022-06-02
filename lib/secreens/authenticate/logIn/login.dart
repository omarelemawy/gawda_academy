import 'package:country_code_picker/country_code_picker.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/userData.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/authenticate/register/register.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/splashscreen.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/wrapper/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:elgawda_by_shay_b_haleb_new/models/utils.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:convert';

import '../../../main.dart';
import '../../../models/language.dart';
import '../../../sharedPreferences.dart';
import '../passwordRecovery.dart';
import '../register/phon_verification_screen.dart';

class LogIn extends StatefulWidget {
  final Function? toggleView;

  LogIn({this.toggleView});

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool obscurePassword = true;
  String? phoneNamber;
  String? password;
  String countryCode="+20";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    double height = MediaQuery.of(context).size.height;
    void _changeLanguage(Language language) async {
      Locale _locale = await setLocale(language.languageCode);

      MyApp.setLocale(context, _locale);

      MySharedPreferences.saveAppLang(_locale.toString());
      UserApp.appLang = await MySharedPreferences.getAppLang();
    }
    Widget lan() {
      return SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            /*Expanded(
              child: Text(
                getTranslated(context, 'change_language')!,
                style: AppTheme.headingColorBlue,
              ),
            ),*/
            DropdownButton<Language>(
              dropdownColor: Colors.white,
              underline: SizedBox(),
              icon: Icon(
                Icons.language,
                color: customColor,
              ),
              onChanged: (Language? language) {
                _changeLanguage(language!);
                print(language.toString());
              },
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                  value: e,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        e.flag,
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(e.name)
                    ],
                  ),
                ),
              )
                  .toList(),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: (loading)
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : ListView(
              shrinkWrap: true,
              primary: true,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              children: [
                lan(),
                LogoContainar(),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      getTranslated(context, 'Welcome').toString(),
                      style: AppTheme.heading.copyWith(
                        color: customColorGold,
                        fontSize: 20,
                      ),
                    ),
                    Text(' '),
                    Text(
                      getTranslated(context, 'Back').toString(),
                      style: AppTheme.heading.copyWith(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '!',
                      style: AppTheme.heading.copyWith(
                        color: customColorGold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      primary: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: CountryCodePicker(
                                      onChanged: (print) {
                                        countryCode = print.toString();
                                      },
                                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                      initialSelection: 'EG',
                                      favorite: ['+20', 'EG'],
                                      // optional. Shows only country name and flag
                                      showCountryOnly: false,
                                      // optional. Shows only country name and flag when popup is closed.
                                      showOnlyCountryWhenClosed: false,
                                      // optional. aligns the flag and the Text left
                                      alignLeft: false,
                                    ),
                                    flex: 2,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(color: Colors.black),
                                      validator: (val) =>
                                      val!.isEmpty
                                          ? getTranslated(
                                          context, 'valid_phone')
                                          : null,
                                      onChanged: (val) {
                                        phoneNamber = val;
                                      },
                                      decoration: textFormInputDecoration(
                                        Icons.phone,
                                        getTranslated(context, 'phone_numer')
                                            .toString(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              // TextFormField(
                              //   style: TextStyle(color: Colors.black),
                              //   keyboardType: TextInputType.phone,
                              //   decoration: textFormInputDecoration(
                              //     Icons.login,
                              //     getTranslated(
                              //         context, 'email_or_phone_number').toString(),
                              //   ),
                              //   validator: (val) => val!.isEmpty
                              //       ? getTranslated(
                              //           context, 'valid_email_phone')
                              //       : null,
                              //   onChanged: (val) {
                              //     setState(() {
                              //       phoneNamber = val;
                              //     });
                              //   },
                              // ),
                              SizedBox(height: 20),
                              TextFormField(
                                style: TextStyle(color: Colors.black),
                                decoration: textFormInputDecorationForPassword(
                                  Icons.visibility_off,
                                  getTranslated(context, 'password').toString(),
                                  () {
                                    setState(() {
                                      obscurePassword = !obscurePassword;
                                    });
                                  },
                                  obscurePassword,
                                ),
                                validator: (val) => val!.isEmpty
                                    ? getTranslated(context, 'valid_password')
                                    : null,
                                obscureText: obscurePassword,
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                              ),
                              SizedBox(height: 10),
                              CustomButton(
                                onPress: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    logInWithPhoneAndPassword(
                                      phoneNummber: phoneNamber.toString(),
                                      password: password.toString(),
                                    );
                                  }
                                },
                                text: getTranslated(context, 'sign_in').toString(),
                              ),
                              SizedBox(height: 12),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => PasswordRecovery(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      getTranslated(context, 'forget_password').toString(),
                                      style:
                                          AppTheme.headingColorBlue.copyWith(),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 1,
                                    width: width * .3,
                                    color: customColor,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    getTranslated(context, 'or').toString(),
                                    style: AppTheme.headingColorBlue.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                    height: 1,
                                    width: width * .3,
                                    color: customColor,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        getTranslated(
                                            context, "don't_have_an_account").toString(),
                                        style: AppTheme.subHeadingColorBlue
                                            .copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () => Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => PhoneVerification(
                                                toggleView: widget.toggleView,
                                              ),
                                            ),(c)=>false),
                                        child: Text(
                                          getTranslated(context, "sign_up").toString(),
                                          style: AppTheme.headingColorBlue
                                              .copyWith(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // SizedBox(height: 10),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: [
                              //     InkWell(
                              //       onTap: () {
                              //         setState(() {
                              //           loading = !loading;
                              //         });
                              //         _googleLogIn();
                              //       },
                              //       child: Icon(
                              //         FontAwesomeIcons.google,
                              //         color: Colors.redAccent,
                              //         size: 35,
                              //       ),
                              //     ),
                              //     SizedBox(width: 30),
                              //     InkWell(
                              //       onTap: () {
                              //         setState(() {
                              //           loading = !loading;
                              //         });
                              //         _fblogin();
                              //       },
                              //       child: Icon(
                              //         FontAwesomeIcons.facebook,
                              //         color: Colors.blueAccent,
                              //         size: 35,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(height: 10),
                              // Container(
                              //   height: height * 0.05,
                              //   width: width * 0.67,
                              //   margin: EdgeInsets.symmetric(vertical: 10),
                              //   child: SignInWithAppleButton(
                              //     onPressed: () async {
                              //       await _appleLogin();
                              //     },
                              //   ),
                              // )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
    );
  }

  logInWithPhoneAndPassword({
    String? phoneNummber,
    String? password,
  }) async {
    String phone;
    if (phoneNummber!.split("")[0]=="0")
    {
      phone=phoneNummber.substring(1);
    }else{
      phone=phoneNummber;
    }
    try {
      var response = await http.post(Utils.LOGIN_URL, body: {
        'email': countryCode+phone,
        'password': password,
      }, headers: {
        'lang': apiLang(),
      });

      var map = json.decode(response.body);

      if (map['success'] == true) {
        setState(() {
          UserApp.userToken = map['data']['api_token'].toString();
        });
        print("tokkkken:${map['data']['api_token']}");
        MySharedPreferences.saveUserSingIn(true);
        MySharedPreferences.saveUserSkipLogIn(false);
        MySharedPreferences.saveUserUserPassword(password!);

        MySharedPreferences.saveUserUserToken(
          map['data']['api_token'].toString(),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => Wrapper(),
          ),
        );
      } else {
        setState(() {
          showMyDialog(
            context: context,
            message: map['message'].toString(),
            isTrue: false,
          );

          loading = false;
        });
      }

      // Navigator.pop(context);
    } catch (e) {
      print('Cash LogIn Errro');

      setState(() {
        loading = false;
      });
      showMyDialog(
        isTrue: false,
        context: context,
        message: getTranslated(context, 'catchError'),
      );

      print(e.toString());
    }
  }

  _loginWithGOOGLe({googleID, name}) async {
    try {
      var response = await http.post(
        Utils.GOOGLE_URL,
        body: {
          'google_id': googleID,
          'name': name,
        },
        headers: {
          'lang': apiLang(),
        },
      );
      print(response.statusCode);

      Map<String, dynamic> map = json.decode(response.body);
      print(map);

      // print('this is the userData data ${userData}');
      if (map['success'] == true) {
        setState(() {
          UserApp.userToken = map['data']['api_token'].toString();
        });
        MySharedPreferences.saveUserSingIn(true);
        MySharedPreferences.saveUserSkipLogIn(false);

        MySharedPreferences.saveUserUserName(
          map['data']['name'].toString(),
        );

        MySharedPreferences.saveUserUserToken(
          map['data']['api_token'].toString(),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => Wrapper(),
          ),
        );
      } else {
        setState(() {
          error = map['message'].toString();
          loading = !loading;
        });
      }

      // Navigator.pop(context);
    } catch (e) {
      setState(() {
        loading = !loading;
      });
      showMyDialog(
        isTrue: false,
        context: context,
        message: getTranslated(context, 'catchError'),
      );
      print(
          'Catchhhhhhhhhhhhhhhhhhhhhhh errororororrorrorooroeoreoroeroeorero');
      print(e.toString());
    }
  }

  // ignore: unused_element
  _googleLogIn() async {
    try {
      GoogleSignIn _googleSginIn = GoogleSignIn(scopes: ['email']);
      await _googleSginIn.signIn();
      setState(() {
        loading = !loading;
      });
      print(_googleSginIn.currentUser!.displayName);
      print(_googleSginIn.currentUser!.id);
      MySharedPreferences.saveUserUserEmail(
          _googleSginIn.currentUser!.email.toString());

      _loginWithGOOGLe(
        googleID: _googleSginIn.currentUser!.id,
        name: _googleSginIn.currentUser!.email,
      );
    } catch (e) {
      showMyDialog(
        isTrue: false,
        context: context,
        message: getTranslated(context, 'catchError'),
      );
      print("catssssssssss eroooooooooooooor");
      print(e.toString());
    }
  }

  _loginWithApple({appleID, name}) async {
    try {
      var response = await http.post(
        Utils.APPLE_URL,
        body: {
          ' apple_id': appleID,
          'name': name,
        },
        headers: {
          'lang': apiLang(),
        },
      );
      print(response.statusCode);

      Map<String, dynamic> map = json.decode(response.body);
      print(map);

      if (map['success'] == true) {
        setState(() {
          UserApp.userToken = map['data']['api_token'].toString();
        });
        MySharedPreferences.saveUserSingIn(true);
        MySharedPreferences.saveUserSkipLogIn(false);

        MySharedPreferences.saveUserUserName(
          map['data']['name'].toString(),
        );

        MySharedPreferences.saveUserUserToken(
          map['data']['api_token'].toString(),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => Wrapper(),
          ),
        );
      } else {
        setState(() {
          error = map['message'].toString();
          loading = !loading;
        });
      }

      // Navigator.pop(context);
    } catch (e) {
      setState(() {
        loading = !loading;
      });
      showMyDialog(
        isTrue: false,
        context: context,
        message: getTranslated(context, 'catchError'),
      );
      print(
          'Catchhhhhhhhhhhhhhhhhhhhhhh errororororrorrorooroeoreoroeroeorero');
      print(e.toString());
    }
  }

  // ignore: unused_element
  _appleLogin() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      print(
        'Apple Token:{ ${credential.identityToken} }',
      );
      _loginWithApple(
        appleID: credential.identityToken,
        name: credential.givenName,
      );
    } catch (e) {
      showMyDialog(
        isTrue: false,
        context: context,
        message: getTranslated(context, 'catchError'),
      );
      print("apple login eroooooooooooooor");
      print(e.toString());
    }
  }

  _loginWithFB(fbID, name) async {
    try {
      var response = await http.post(
        Utils.FACEBOOK_URL,
        body: {
          'fb_id': fbID,
          'name': name,
        },
        headers: {
          'lang': UserApp.apiLang,
        },
      );
      print(response.statusCode);

      Map<String, dynamic> map = json.decode(response.body);
      print(map);

      if (map['success'] == true) {
        setState(() {
          UserApp.userToken = map['data']['api_token'].toString();
        });
        MySharedPreferences.saveUserSingIn(true);
        MySharedPreferences.saveUserSkipLogIn(false);

        MySharedPreferences.saveUserUserName(
          map['data']['name'].toString(),
        );

        MySharedPreferences.saveUserUserToken(
          map['data']['api_token'].toString(),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => Wrapper(),
          ),
        );
      } else {
        setState(() {
          loading = !loading;
        });
      }
    } catch (e) {
      setState(() {
        loading = !loading;
      });
      showMyDialog(
        isTrue: false,
        context: context,
        message: getTranslated(context, 'catchError'),
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => SplashScreen(),
            ),
          );
        },
      );

      print(e.toString());
    }
  }

  final FacebookLogin facebookSignIn = new FacebookLogin();

  // ignore: unused_element
  _fblogin() async {
    // final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    final FacebookLoginResult result = await facebookSignIn.logIn();

    try {
      switch (result.status) {
        case FacebookLoginStatus.success:
          final FacebookAccessToken? accessToken = result.accessToken;
          final token = result.accessToken!.token;

          final graphResponse = await http.get(
            Uri.parse(
                'https://graph.facebook.com/v2.12/me?fields=name,email&access_token=$token'),
            headers: {
              'lang': UserApp.apiLang,
            },
          );
          final profile = json.decode(graphResponse.body);
          _loginWithFB(
            accessToken!.userId,
            profile['name'],
          );

          break;
        case FacebookLoginStatus.cancel:
          print('Login cancelled by the user.');
          setState(() {
            loading = !loading;
          });
          break;
        case FacebookLoginStatus.error:
          print(result.error);
          setState(() {
            loading = !loading;
          });

          showMyDialog(
            isTrue: false,
            context: context,
            message: 'Something went wrong with the login process.\n'
                'Here\'s the error Facebook gave us: ${result.error}',
          );

          break;
      }
    } catch (e) {
      setState(() {
        loading = !loading;
      });
      showMyDialog(
        isTrue: false,
        context: context,
        message: 'Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.error}',
      );
    }
  }
}
