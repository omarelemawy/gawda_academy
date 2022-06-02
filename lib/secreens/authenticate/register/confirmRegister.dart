import 'dart:async';

import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/authenticate/restPassword/resetPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:elgawda_by_shay_b_haleb_new/models/utils.dart';
import 'dart:convert';

import 'package:pin_code_fields/pin_code_fields.dart';

class ConfirmPassword extends StatefulWidget {
  final String? email;

  const ConfirmPassword({Key? key, required this.email}) : super(key: key);
  @override
  _ConfirmPasswordState createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  final _formKey = GlobalKey<FormState>();
  final int codeLength = 4;
  int counter = 60;
  String? code;
  bool loading = false;

  Timer? _timer;

  String? validateCode(String code) {
    if (code.length < codeLength)
      return  "من فضلك اكمل الكود";
    else {
      bool isNumeric = int.tryParse(code) != null;
      if (!isNumeric) return "برجاء ادخال الكود المرسل";
    }
    return null;
  }

  startTimer() {
    counter = 60;
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {
          if (counter > 0) {
            counter--;
          } else {
            _timer!.cancel();
          }
        });
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: (loading)
            ? Container(
                child: Center(
                  child: SpinKitChasingDots(
                    color: customColor,
                    size: 40,
                  ),
                ),
              )
            : ListView(
                primary: true,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                children: [
                  LogoContainar(),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getTranslated(context, 'Confrim').toString(),
                            style: AppTheme.heading.copyWith(
                              color: customColor,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 40),
                          Center(
                            child: Text(
                              getTranslated(context, 'code_sent').toString() +
                                  '\n' +
                                  widget.email.toString(),
                              textAlign: TextAlign.center,
                              style: AppTheme.subHeading.copyWith(),
                            ),
                          ),
                          SizedBox(height: 40),
                          Center(
                            child: PinCodeTextField(
                              length: codeLength,
                              onCompleted: (val) {
                                _timer!.cancel();
                                code = val;
                                setState(() {
                                  loading = !loading;
                                });

                                checkCode();
                              },
                              onChanged: (val) {
                                code = val;
                              },
                              validator:(v) {
                                if (v!.length < codeLength)
                                  return  "من فضلك اكمل الكود";
                                else {
                                  bool isNumeric = int.tryParse(code!) != null;
                                  if (!isNumeric) return "برجاء ادخال الكود المرسل";
                                }
                                return null;
                              },
                              textStyle: TextStyle(color: Colors.black),
                              autoFocus: true,
                              appContext: context,
                            ),
                          ),
                          SizedBox(height: 20),
                          (counter > 0)
                              ? Center(
                                  child: Text(
                                    counter.toString(),
                                    style: AppTheme.headingColorBlue.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: InkWell(
                                    onTap: () {
                                      startTimer();
                                      resendForgetCode();
                                    },
                                    child: Text(
                                      getTranslated(context, 'ResendCode').toString() +
                                          " ?",
                                      style:
                                          AppTheme.headingColorBlue.copyWith(),
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
    );
  }

  resendForgetCode() async {
    try {
      var response = await http.post(
        Utils.SendForgetCode_URL,
        body: {
          'email': widget.email,
        },
        headers: {
          'lang': apiLang(),
        },
      );

      Map<String, dynamic> map = json.decode(response.body);

      if (map['success'] == true) {
      } else {
        showMyDialog(
          isTrue: false,
          context: context,
          message: map['message'],
        );
      }
    } catch (e) {
      print('Cash Forgtin  Password Errro');

      showMyDialog(
        isTrue: false,
        context: context,
        message: getTranslated(context, 'catchError'),
      );

      print(e.toString());
    }
  }

  checkCode() async {
    try {
      var response = await http.post(
        Utils.CheckForgetCode_URL,
        body: {
          'email': widget.email,
          'code': code,
        },
        headers: {
          'lang': apiLang(),
        },
      );

      Map<String, dynamic> map = json.decode(response.body);

      if (map['success'] == true) {
        setState(() {
          loading = !loading;
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => ResetPassword(
              email: widget.email,
            ),
          ),
        );
      } else {
        setState(() {
          loading = !loading;
        });
        showMyDialog(
          isTrue: false,
          context: context,
          message: map['message'],
        );
      }
    } catch (e) {
      setState(() {
        loading = !loading;
      });
      print('Cash Forgtin  Password Errro');

      showMyDialog(
        isTrue: false,
        context: context,
        message: getTranslated(context, 'catchError'),
      );

      print(e.toString());
    }
  }
}
