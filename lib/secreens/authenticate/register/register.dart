import 'dart:async';

import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/userData.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/utils.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/authenticate/logIn/login.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/authenticate/register/phon_verification_screen.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/wrapper/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:queen_validators/queen_validators.dart';
import 'dart:convert';

import '../../../sharedPreferences.dart';

class Register extends StatefulWidget {
  final Function? toggleView;
   String? phoneNumber;

  Register({this.toggleView,this.phoneNumber});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // String? phoneNumber;
  String? password;
  String? confirmPassword;
  String? name;
  String? email;
  int counter = 60;
  bool obscurePassword = true;
  bool obscureconPassword = true;
  String? verificationId;
  var currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  String? verificationCode;

  String countryCode="+20";

  final int codeLength = 6;

  String? code;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        toolbarHeight: 0,
      ),
      body: (loading)
          ? Container(
              child: Center(
                child: SpinKitChasingDots(
                  color: customColor,
                  size: 40,
                ),
              ),
            )
          : Container(
              child:  ListView(
                      shrinkWrap: true,
                      primary: true,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      children: [
                        LogoContainar(),
                        SizedBox(height: 40),
                        Row(
                          children: [
                            Text(
                              getTranslated(context, 'create').toString(),
                              style: AppTheme.heading.copyWith(
                                color: customColorGold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              getTranslated(context, 'an_account').toString(),
                              style: AppTheme.heading.copyWith(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      TextFormField(
                                        style: TextStyle(color: Colors.black),
                                        validator: (val) => val!.isEmpty
                                            ? getTranslated(
                                                context, 'valid_name')
                                            : null,
                                        onChanged: (val) {
                                          setState(() {
                                            name = val;
                                          });
                                        },
                                        decoration: textFormInputDecoration(
                                          Icons.person,
                                          getTranslated(context, 'full_name')
                                              .toString(),
                                        ),
                                      ),
                                     /* SizedBox(height: 10),*/
                                      /*Row(
                                        children: [
                                          Expanded(
                                            child: CountryCodePicker(
                                              onChanged: (print)
                                              {
                                                countryCode=print.toString();
                                              },
                                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                              initialSelection: 'EG',
                                              favorite: ['+20','EG'],
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
                                            child:TextFormField(
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(color: Colors.black),
                                            validator: (val) => val!.isEmpty
                                                ? getTranslated(
                                                    context, 'valid_phone')
                                                : null,
                                            onChanged: (val) {
                                              setState(() {
                                                phoneNumber = val;
                                              });
                                            },
                                            decoration: textFormInputDecoration(
                                              Icons.phone,
                                              getTranslated(context, 'phone_numer')
                                                  .toString(),
                                            ),
                                          ),
                                          )
                                        ],
                                      ),*/
                                      SizedBox(height: 10),
                                      TextFormField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style: TextStyle(color: Colors.black),
                                          /*  validator: (val) => val.isEmpty
                                        ? getTranslated(context, 'valid_email')
                                        : null,*/
                                          // use qValidator function and provider list of rules to apply on this field
                                          validator: qValidator([
                                            IsRequired(),
                                            IsEmail(),
                                            MinLength(8),
                                            MaxLength(30,
                                                "optionally you can override the failure if the validation fails"),
                                          ]),
                                          onChanged: (val) {
                                            setState(() {
                                              email = val;
                                            });
                                          },
                                          decoration: textFormInputDecoration(
                                            Icons.email,
                                            getTranslated(context, 'email')
                                                .toString(),
                                          ),
                                        ),
                                      SizedBox(height: 10),
                                      TextFormField(
                                        style: TextStyle(color: Colors.black),
                                        decoration:
                                            textFormInputDecorationForPassword(
                                          Icons.visibility_off,
                                          getTranslated(context, 'password')
                                              .toString(),
                                          () {
                                            setState(() {
                                              obscurePassword =
                                                  !obscurePassword;
                                            });
                                          },
                                          obscurePassword,
                                        ),
                                        validator: (val) =>
                                            validatePassord(val!),
                                        obscureText: obscurePassword,
                                        onChanged: (val) {
                                          setState(() {
                                            password = val;
                                          });
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      TextFormField(
                                        style: TextStyle(color: Colors.black),
                                        decoration:
                                            textFormInputDecorationForPassword(
                                          Icons.visibility_off,
                                          getTranslated(context,
                                                  'confirm_the_password')
                                              .toString(),
                                          () {
                                            setState(() {
                                              obscureconPassword =
                                                  !obscureconPassword;
                                            });
                                          },
                                          obscureconPassword,
                                        ),
                                        validator: (val) =>
                                            validateConfrimPassword(
                                          val!,
                                          password!,
                                          confirmPassword!,
                                        ),
                                        obscureText: obscureconPassword,
                                        onChanged: (val) {
                                          setState(() {
                                            confirmPassword = val;
                                          });
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      CustomButton(
                                        onPress: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              loading = true;
                                            });
                                            print("1111111");
                                            registerWithPhoneAndPassword(
                                              name: name,
                                              password_confirmation: confirmPassword,
                                              email: email,
                                              mobile: widget.phoneNumber,
                                              password: password,
                                            );
                                            /*verificationPhone();*/
                                          }
                                        },
                                        text: getTranslated(context, 'sign_up')
                                            .toString(),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 1,
                                            width: width * .3,
                                            color: customColor,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            getTranslated(context, 'or')
                                                .toString(),
                                            style: AppTheme.headingColorBlue
                                                .copyWith(
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                getTranslated(context,
                                                        'already_have_an_account')
                                                    .toString(),
                                                style: AppTheme
                                                    .subHeadingColorBlue
                                                    .copyWith(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(' '),
                                              InkWell(
                                                onTap: () => Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) => LogIn(
                                                              toggleView: widget
                                                                  .toggleView,
                                                            )),(c)=>false),
                                                child: Text(
                                                  getTranslated(
                                                          context, 'sign_in')
                                                      .toString(),
                                                  style: AppTheme
                                                      .headingColorBlue
                                                      .copyWith(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
    );
  }

  /*void signInWithPhonAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      loading = true;
    });
    try {
      var userCredential =
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      if (userCredential.user != null) {
        registerWithPhoneAndPassword(
          name: name,
          password_confirmation: confirmPassword,
          email: email,
          mobile: phoneNumber,
          password: password,
        );
      }
    } on FirebaseAuthException catch (e) {}
  }*/

  // Widget getOTPForm(context) {
  //
  //   return ListView(
  //     shrinkWrap: true,
  //     primary: true,
  //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  //     children: [
  //       const LogoContainar(),
  //       const SizedBox(height: 20),
  //       Row(
  //         children: [
  //           Text(
  //             getTranslated(context, 'create')!,
  //             style: AppTheme.heading.copyWith(
  //               color: customColorGold,
  //               fontSize: 20,
  //             ),
  //           ),
  //           Text(
  //             getTranslated(context, 'an_account')!,
  //             style: AppTheme.heading.copyWith(
  //               fontSize: 20,
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: 20),
  //       Padding(
  //         padding: const EdgeInsets.only(left: 10, right: 10),
  //         child: SingleChildScrollView(
  //           child: Column(
  //             children: [
  //               const SizedBox(height: 15),
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   PinCodeTextField(
  //                     length: codeLength,
  //                     // onCompleted: (val) {
  //                     //   _timer!.cancel();
  //                     //   code = val;
  //                     //   setState(() {
  //                     //     loading = !loading;
  //                     //   });
  //                     //   PhoneAuthCredential phoneAuthCredential =
  //                     //   PhoneAuthProvider.credential(
  //                     //       verificationId: verificationId!,
  //                     //       smsCode: verificationCode!);
  //                     //   signInWithPhonAuthCredential(phoneAuthCredential);
  //                     // },
  //                     onChanged: (val) {
  //                       code = val;
  //                     },
  //                     validator:(v) {
  //                       if (v!.length < codeLength)
  //                         return  "من فضلك اكمل الكود";
  //                       else {
  //                         bool isNumeric = int.tryParse(code!) != null;
  //                         if (!isNumeric) return "برجاء ادخال الكود المرسل";
  //                       }
  //                       return null;
  //                     },
  //                     textStyle: TextStyle(color: Colors.black),
  //                     autoFocus: true,
  //                     appContext: context,
  //                   ),
  //                   // TextFormField(
  //                   //   style: const TextStyle(color: Colors.black),
  //                   //   validator: (val) => val!.isEmpty
  //                   //       ? getTranslated(context, 'valid_name')
  //                   //       : null,
  //                   //   onChanged: (val) {
  //                   //     setState(() {
  //                   //       verificationCode = val;
  //                   //     });
  //                   //   },
  //                   //   decoration: textFormInputDecoration(
  //                   //     Icons.person,
  //                   //     getTranslated(context, 'full_name').toString(),
  //                   //   ),
  //                   // ),
  //                   // const SizedBox(height: 10),
  //                   // TextFormField(
  //                   //   keyboardType: TextInputType.number,
  //                   //   style: const TextStyle(color: Colors.black),
  //                   //   validator: (val) => val!.isEmpty
  //                   //       ? getTranslated(context, 'valid_phone')
  //                   //       : null,
  //                   //   onChanged: (val) {
  //                   //     setState(() {
  //                   //       phoneNumber = val;
  //                   //     });
  //                   //   },
  //                   //   decoration: textFormInputDecoration(
  //                   //     Icons.phone,
  //                   //     getTranslated(context, 'phone_numer')
  //                   //         .toString(),
  //                   //   ),
  //                   // ),
  //                   // const SizedBox(height: 10),
  //                   // TextFormField(
  //                   //   keyboardType: TextInputType.emailAddress,
  //                   //   style: const TextStyle(color: Colors.black),
  //                   //   /*  validator: (val) => val.isEmpty
  //                   //                 ? getTranslated(context, 'valid_email')
  //                   //                 : null,*/
  //                   //   // use qValidator function and provider list of rules to apply on this field
  //                   //   validator: qValidator([
  //                   //     IsRequired(),
  //                   //     const IsEmail(),
  //                   //     MinLength(8),
  //                   //     MaxLength(30,
  //                   //         "optionally you can override the failure if the validation fails"),
  //                   //   ]),
  //                   //   onChanged: (val) {
  //                   //     setState(() {
  //                   //       email = val;
  //                   //     });
  //                   //   },
  //                   //   decoration: textFormInputDecoration(
  //                   //     Icons.email,
  //                   //     getTranslated(context, 'email').toString(),
  //                   //   ),
  //                   // ),
  //                   // const SizedBox(height: 10),
  //                   // TextFormField(
  //                   //   style: const TextStyle(color: Colors.black),
  //                   //   decoration: textFormInputDecorationForPassword(
  //                   //     Icons.visibility_off,
  //                   //     getTranslated(context, 'password').toString(),
  //                   //         () {
  //                   //       setState(() {
  //                   //         obscurePassword = !obscurePassword;
  //                   //       });
  //                   //     },
  //                   //     obscurePassword,
  //                   //   ),
  //                   //   validator: (val) => validatePassord(val!),
  //                   //   obscureText: obscurePassword,
  //                   //   onChanged: (val) {
  //                   //     setState(() {
  //                   //       password = val;
  //                   //     });
  //                   //   },
  //                   // ),
  //                   // const SizedBox(height: 10),
  //                   // TextFormField(
  //                   //   style: const TextStyle(color: Colors.black),
  //                   //   decoration: textFormInputDecorationForPassword(
  //                   //     Icons.visibility_off,
  //                   //     getTranslated(context, 'confirm_the_password')
  //                   //         .toString(),
  //                   //         () {
  //                   //       setState(() {
  //                   //         obscureconPassword = !obscureconPassword;
  //                   //       });
  //                   //     },
  //                   //     obscureconPassword,
  //                   //   ),
  //                   //   validator: (val) => validateConfrimPassord(
  //                   //     val!,
  //                   //     password!,
  //                   //     confirmPassword!,
  //                   //   ),
  //                   //   obscureText: obscureconPassword,
  //                   //   onChanged: (val) {
  //                   //     setState(() {
  //                   //       confirmPassword = val;
  //                   //     });
  //                   //   },
  //                   // ),
  //                   // const SizedBox(height: 10),
  //                   SizedBox(height: 20),
  //                   (counter > 0)
  //                       ? Center(
  //                     child: Text(
  //                       counter.toString(),
  //                       style: AppTheme.headingColorBlue.copyWith(
  //                         fontSize: 20,
  //                         fontWeight: FontWeight.w700,
  //                       ),
  //                     ),
  //                   )
  //                       : Center(
  //                     child: InkWell(
  //                       onTap: () {
  //                         startTimer();
  //                         resendForgetCode();
  //                       },
  //                       child: Text(
  //                         getTranslated(context, 'ResendCode').toString() +
  //                             " ?",
  //                         style:
  //                         AppTheme.headingColorBlue.copyWith(),
  //                       ),
  //                     ),
  //                   ),
  //                   CustomButton(
  //                     onPress: () async {
  //
  //                         PhoneAuthCredential phoneAuthCredential =
  //                             PhoneAuthProvider.credential(
  //                                 verificationId: verificationId!,
  //                                 smsCode: code!);
  //                         signInWithPhonAuthCredential(phoneAuthCredential);
  //
  //                     },
  //                     text: getTranslated(context, 'sign_up').toString(),
  //                   ),
  //                   const SizedBox(height: 10),
  //                   const SizedBox(height: 10),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  resendForgetCode() async {

  }
  registerWithPhoneAndPassword({
    // ignore: non_constant_identifier_names
    String? mobile,
    // ignore: non_constant_identifier_names
    String? email,
    // ignore: non_constant_identifier_names
    String? name,
    // ignore: non_constant_identifier_names
    String? password_confirmation,
    // ignore: non_constant_identifier_names
    String? password,
  }) async {
    try {
      // Dio dio = new Dio();

      var response = await http.post(Utils.REGISTER_URL,
          // Utils.REGISTER_URL,
          body: {
            'name': name,
            'email': email,
            'mobile': mobile,
            'password': password,
            'password_confirmation': password_confirmation,
          }, headers: {
        'lang': apiLang(),
      });
      Map<String, dynamic> map = json.decode(response.body);
      print('stuates Code:${response.statusCode}');
      print('stuates Code:${response.body}');

      if (map['success'] == true) {
        setState(() {
          UserApp.userToken = map['data']['api_token'].toString();
        });
        MySharedPreferences.saveUserUserToken(
          map['data']['api_token'].toString(),
        );
        MySharedPreferences.saveUserSingIn(true);
        MySharedPreferences.saveUserSkipLogIn(false);
        MySharedPreferences.saveUserUserPassword(password!);
        UserApp.userLogIn = await MySharedPreferences.getUserSingIn();
        UserApp.userSkipLogIn = await MySharedPreferences.getUserSkipLogIn();

        // PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode)
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => Wrapper(),
          ),
        );
      } else {
        setState(() {
          loading = false;
        });
        showMyDialog(
            isTrue: false,
            context: context,
            message: map['message'].toString());
      }

      // Navigator.pop(context);
    } catch (e) {
      print('Cash Resster Errro');
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
  /*void verificationPhone() async {
    print("object");

     String phone;
    if (phoneNumber!.split("")[0]=="0")
      {
        phone=phoneNumber!.substring(1);
      }else{
      phone=phoneNumber!;
    }
    print(countryCode+phone);
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: countryCode+phone,
        verificationCompleted: (phoneAuthCredential) async {
          registerWithPhoneAndPassword(
            name: name,
            password_confirmation: confirmPassword,
            email: email,
            mobile: phoneNumber,
            password: password,
          );
        },
        verificationFailed: (verificationFailed) async {
          print(verificationFailed.message);
          setState(() {
            loading = false;
          });

          currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
          // showMyDialog(
          //     isTrue: false,
          //     context: context,
          //     message: verificationFailed.message);
        },
        codeSent: (verificationId, reSendingToken) async {
          setState(() {
            loading = false;
          });
          setState(() {
            currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
            this.verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) async {});
  }
*/
  String? validatePassord(String val) {
    if (val.isEmpty) {
      return getTranslated(context, "valid_password").toString();
    } else if (val.length < 6) {
      return getTranslated(context, "valid_password_len").toString();
    } else {
      return null;
    }
  }

  String? validateConfrimPassword(
    String val,
    String password,
    String confrimPassord,
  ) {
    if (val.isEmpty) {
      return getTranslated(context, "valid_password").toString();
    } else if (password != confirmPassword) {
      return getTranslated(context, "password_not_mat").toString();
    } else {
      return null;
    }
  }
}

enum MobileVerificationState { SHOW_MOBILE_FORM_STATE, SHOW_OTP_FORM_STATE }
