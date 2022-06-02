import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/authenticate/first_sign_screen.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/authenticate/register/cubit/phone_cubit.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/authenticate/register/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../constants/constans.dart';
import '../../../constants/themes.dart';
import '../../../localization/localization_constants.dart';
import '../../../main.dart';
import '../../../models/language.dart';
import '../../../models/userData.dart';
import '../../../sharedPreferences.dart';
import '../logIn/login.dart';

class PhoneVerification extends StatelessWidget {
  PhoneVerification({Key? key,this.toggleView}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  String? phoneNumber;
  String? password;
  String? confirmPassword;
  String? name;
  String? email;
  bool obscurePassword = true;
  bool obscureconPassword = true;
  String? verificationId;
   final Function? toggleView;
  var currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  Duration? timerTastoPremuto;
  String? verificationCode;

  String countryCode="+20";

  final int codeLength = 6;
   final CountDownController _controller =
  CountDownController();
  String? code;
  @override
  Widget build(BuildContext context) {
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

    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => PhoneCubit(),
      child: BlocConsumer<PhoneCubit,PhoneState>(
        builder: (context, state)
        {
          var phoneCubit = PhoneCubit.get(context);
         return Scaffold(
        appBar: AppBar(

          backgroundColor: customColor,
          toolbarHeight: 0,
        ),
        body: (PhoneCubit.get(context).loading)
            ? Container(
          child: Center(
            child: SpinKitChasingDots(
              color: customColor,
              size: 40,
            ),
          ),
        )
            : Container(
          child: currentState == MobileVerificationState.SHOW_OTP_FORM_STATE
              ? getOTPForm(context)
              : ListView(
            shrinkWrap: true,
            primary: true,
            padding:
            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
              lan(),
              LogoContainar(),
              SizedBox(height: 50),
              Row(
                children: [
                  Text(
                    getTranslated(context, 'Verify')!,
                    style: AppTheme.heading.copyWith(
                      color: customColorGold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    getTranslated(context, 'Your Phone')!,
                    style: AppTheme.heading.copyWith(
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
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
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
                                      phoneNumber = val;
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
                            SizedBox(height: 50),
                            CustomButton(
                              onPress: () async {
                                if (_formKey.currentState!
                                    .validate()) {
                                  phoneCubit.changeLoadingState(true);
                                  print("1111111");
                                  verificationPhone(context);
                                }
                              },
                              text: getTranslated(context, 'verify')
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
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => LogIn(
                                                toggleView: toggleView,
                                              ))),
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
                            // Row(
                            //   mainAxisAlignment:
                            //   MainAxisAlignment.center,
                            //   crossAxisAlignment:
                            //   CrossAxisAlignment.center,
                            //   children: [
                            //     Container(
                            //       height: 1,
                            //       width: width * .3,
                            //       color: customColor,
                            //     ),
                            //     SizedBox(width: 5),
                            //     Text(
                            //       getTranslated(context, 'or')
                            //           .toString(),
                            //       style: AppTheme.headingColorBlue
                            //           .copyWith(
                            //         fontWeight: FontWeight.w900,
                            //         fontSize: 16,
                            //       ),
                            //     ),
                            //     SizedBox(width: 5),
                            //     Container(
                            //       height: 1,
                            //       width: width * .3,
                            //       color: customColor,
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: 10),
                            // Column(
                            //   children: [
                            //     Row(
                            //       mainAxisAlignment:
                            //       MainAxisAlignment.center,
                            //       crossAxisAlignment:
                            //       CrossAxisAlignment.center,
                            //       children: [
                            //         Text(
                            //           getTranslated(context,
                            //               'already_have_an_account')
                            //               .toString(),
                            //           style: AppTheme
                            //               .subHeadingColorBlue
                            //               .copyWith(
                            //             fontSize: 12,
                            //           ),
                            //         ),
                            //         Text(' '),
                            //         InkWell(
                            //           onTap: () =>
                            //               Navigator.push(
                            //                   context,
                            //                   MaterialPageRoute(
                            //                       builder: (_) =>
                            //                           PhoneVerification(
                            //                             toggleView: toggleView,
                            //                           ))),
                            //           child: Text(
                            //             getTranslated(
                            //                 context, 'sign_in')
                            //                 .toString(),
                            //             style: AppTheme
                            //                 .headingColorBlue
                            //                 .copyWith(
                            //               fontWeight: FontWeight.w900,
                            //               fontSize: 14,
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     SizedBox(height: 10),
                            //   ],
                            // ),
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
        },
        listener: (context,state){},
      ),
    );
  }
  void signInWithPhonAuthCredential(
      PhoneAuthCredential phoneAuthCredential,context) async {

      PhoneCubit.get(context).changeLoadingState(true);
    try {
      var userCredential =
      await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      if (userCredential.user != null) {
        print(userCredential.user!.phoneNumber);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => Register(
                toggleView: toggleView,
                phoneNumber: userCredential.user!.phoneNumber,
              ),
            ),(_)=>false);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Widget getOTPForm(context) {

    return ListView(
      shrinkWrap: true,
      primary: true,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(onPressed: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                  (context)=>FirstSignScreen()),
                      (route) => false);
            }, icon: Icon(Icons.arrow_back_ios),
              color: Colors.black,),
          ],
        ),
        const LogoContainar(),
        const SizedBox(height: 20),
        Row(
          children: [
            Text(
              getTranslated(context, 'Verify')!,
              style: AppTheme.heading.copyWith(
                color: customColorGold,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 5,),
            Text(
              getTranslated(context, 'Your Phone')!,
              style: AppTheme.heading.copyWith(
                fontSize: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PinCodeTextField(
                      keyboardType: TextInputType.number,
                      length: codeLength,
                      // onCompleted: (val) {
                      //   _timer!.cancel();
                      //   code = val;
                      //   setState(() {
                      //     loading = !loading;
                      //   });
                      //   PhoneAuthCredential phoneAuthCredential =
                      //   PhoneAuthProvider.credential(
                      //       verificationId: verificationId!,
                      //       smsCode: verificationCode!);
                      //   signInWithPhonAuthCredential(phoneAuthCredential);
                      // },
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
                    // TextFormField(
                    //   style: const TextStyle(color: Colors.black),
                    //   validator: (val) => val!.isEmpty
                    //       ? getTranslated(context, 'valid_name')
                    //       : null,
                    //   onChanged: (val) {
                    //     setState(() {
                    //       verificationCode = val;
                    //     });
                    //   },
                    //   decoration: textFormInputDecoration(
                    //     Icons.person,
                    //     getTranslated(context, 'full_name').toString(),
                    //   ),
                    // ),
                    // const SizedBox(height: 10),
                    // TextFormField(
                    //   keyboardType: TextInputType.number,
                    //   style: const TextStyle(color: Colors.black),
                    //   validator: (val) => val!.isEmpty
                    //       ? getTranslated(context, 'valid_phone')
                    //       : null,
                    //   onChanged: (val) {
                    //     setState(() {
                    //       phoneNumber = val;
                    //     });
                    //   },
                    //   decoration: textFormInputDecoration(
                    //     Icons.phone,
                    //     getTranslated(context, 'phone_numer')
                    //         .toString(),
                    //   ),
                    // ),
                    // const SizedBox(height: 10),
                    // TextFormField(
                    //   keyboardType: TextInputType.emailAddress,
                    //   style: const TextStyle(color: Colors.black),
                    //   /*  validator: (val) => val.isEmpty
                    //                 ? getTranslated(context, 'valid_email')
                    //                 : null,*/
                    //   // use qValidator function and provider list of rules to apply on this field
                    //   validator: qValidator([
                    //     IsRequired(),
                    //     const IsEmail(),
                    //     MinLength(8),
                    //     MaxLength(30,
                    //         "optionally you can override the failure if the validation fails"),
                    //   ]),
                    //   onChanged: (val) {
                    //     setState(() {
                    //       email = val;
                    //     });
                    //   },
                    //   decoration: textFormInputDecoration(
                    //     Icons.email,
                    //     getTranslated(context, 'email').toString(),
                    //   ),
                    // ),
                    // const SizedBox(height: 10),
                    // TextFormField(
                    //   style: const TextStyle(color: Colors.black),
                    //   decoration: textFormInputDecorationForPassword(
                    //     Icons.visibility_off,
                    //     getTranslated(context, 'password').toString(),
                    //         () {
                    //       setState(() {
                    //         obscurePassword = !obscurePassword;
                    //       });
                    //     },
                    //     obscurePassword,
                    //   ),
                    //   validator: (val) => validatePassord(val!),
                    //   obscureText: obscurePassword,
                    //   onChanged: (val) {
                    //     setState(() {
                    //       password = val;
                    //     });
                    //   },
                    // ),
                    // const SizedBox(height: 10),
                    // TextFormField(
                    //   style: const TextStyle(color: Colors.black),
                    //   decoration: textFormInputDecorationForPassword(
                    //     Icons.visibility_off,
                    //     getTranslated(context, 'confirm_the_password')
                    //         .toString(),
                    //         () {
                    //       setState(() {
                    //         obscureconPassword = !obscureconPassword;
                    //       });
                    //     },
                    //     obscureconPassword,
                    //   ),
                    //   validator: (val) => validateConfrimPassord(
                    //     val!,
                    //     password!,
                    //     confirmPassword!,
                    //   ),
                    //   obscureText: obscureconPassword,
                    //   onChanged: (val) {
                    //     setState(() {
                    //       confirmPassword = val;
                    //     });
                    //   },
                    // ),
                    // const SizedBox(height: 10),
                    SizedBox(height: 20),
                    // (PhoneCubit.get(context).resend)?
               //     CountdownTimer(
               //        endTime: PhoneCubit.get(context).endTime,
               //        controller: _controller,
               //        widgetBuilder: (_, CurrentRemainingTime? time) {
               //          if (time == null) {
               //            PhoneCubit.get(context).
               //            changeStateOfTimeState(context,false);
               //            return InkWell(
               //              onTap: () {
               //                // PhoneCubit.get(context).
               //                // changeStateOfTimeState(context,true);
               //                // PhoneCubit.get(context).
               //                // changeTimeState(context,DateTime.now().millisecondsSinceEpoch + 1000 * 60);
               //                resendForgetCode();
               //              },
               //              child: Text(
               //                getTranslated(context, 'ResendCode').toString() +
               //                    " ?",
               //                style:
               //                AppTheme.headingColorBlue.copyWith(),
               //              ),
               //            );
               //          }
               //          return Text(
               //              "${time.sec}") ;
               //        },
               //      ):
               //      Center(
               //     child: InkWell(
               //       onTap: () {
               //     PhoneCubit.get(context).
               //     changeStateOfTimeState(context,true);
               //     PhoneCubit.get(context).
               //     changeTimeState(context,DateTime.now().millisecondsSinceEpoch + 1000 * 60);
               //     resendForgetCode();
               //   },
               //   child: Text(
               //     getTranslated(context, 'ResendCode').toString() +
               //         " ?",
               //     style:
               //     AppTheme.headingColorBlue.copyWith(),
               //   ),
               // ),
               //      )
            PhoneCubit.get(context).resend?
                 CircularCountDownTimer(
                      duration: 60,
                      initialDuration: 0,
                      controller: _controller,
                      width: MediaQuery.of(context).size.width / 6,
                      height: MediaQuery.of(context).size.height / 6,
                      ringColor: Colors.grey[300]!,
                      ringGradient: null,
                      fillColor: Colors.purpleAccent[100]!,
                      fillGradient: null,
                      backgroundColor: Colors.purple[500],
                      backgroundGradient: null,
                      strokeWidth: 20.0,
                      strokeCap: StrokeCap.round,
                      textStyle: TextStyle(
                      fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
                      textFormat: CountdownTextFormat.S,
                      isReverse: false,
                      isReverseAnimation: false,
                      isTimerTextShown: true,
                      autoStart: true,
                      onStart: () {
                        debugPrint('Countdown Started');
                      },
                      onComplete: () {
                        PhoneCubit.get(context).
                        changeStateOfTimeState(context,false);

                        debugPrint('Countdown Ended');
                        debugPrint(PhoneCubit.get(context).resend.toString());
                      },
                    )
                      : Center(
                  child: InkWell(
                    onTap: () {
                  PhoneCubit.get(context).
                  changeStateOfTimeState(context,true);
                  verificationPhone(context);
                  _controller.restart(duration: 60);

                },
                child: Text(
                  getTranslated(context, 'ResendCode').toString() +
                      " ?",
                  style:
                  AppTheme.headingColorBlue.copyWith(),
                ),
              ),
                   )
                    ,CustomButton(
                      onPress: () async {
                        print(verificationId);
                        PhoneCubit.get(context).changeLoadingState(true);
                        if(verificationId !=null){
                          PhoneAuthCredential phoneAuthCredential =
                          PhoneAuthProvider.credential(
                              verificationId: verificationId!,
                              smsCode: code!);
                          signInWithPhonAuthCredential(phoneAuthCredential,context);
                        }
                      },
                      text: getTranslated(context, 'Submit').toString(),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

 /* resendForgetCode() async {

  }*/
  // registerWithPhoneAndPassword({
  //   // ignore: non_constant_identifier_names
  //   String? mobile,
  //   // ignore: non_constant_identifier_names
  //   String? email,
  //   // ignore: non_constant_identifier_names
  //   String? name,
  //   // ignore: non_constant_identifier_names
  //   String? password_confirmation,
  //   // ignore: non_constant_identifier_names
  //   String? password,
  // }) async {
  //   try {
  //     // Dio dio = new Dio();
  //
  //     var response = await http.post(Utils.REGISTER_URL,
  //         // Utils.REGISTER_URL,
  //         body: {
  //           'name': name,
  //           'email': email,
  //           'mobile': mobile,
  //           'password': password,
  //           'password_confirmation': password_confirmation,
  //         }, headers: {
  //           'lang': apiLang(),
  //         });
  //     Map<String, dynamic> map = json.decode(response.body);
  //     print('stuates Code:${response.statusCode}');
  //     print('stuates Code:${response.body}');
  //
  //     if (map['success'] == true) {
  //       setState(() {
  //         UserApp.userToken = map['data']['api_token'].toString();
  //       });
  //       MySharedPreferences.saveUserUserToken(
  //         map['data']['api_token'].toString(),
  //       );
  //       MySharedPreferences.saveUserSingIn(true);
  //       MySharedPreferences.saveUserSkipLogIn(false);
  //       MySharedPreferences.saveUserUserPassword(password!);
  //       UserApp.userLogIn = await MySharedPreferences.getUserSingIn();
  //       UserApp.userSkipLogIn = await MySharedPreferences.getUserSkipLogIn();
  //
  //       // PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode)
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(
  //           builder: (_) => Wrapper(),
  //         ),
  //       );
  //     } else {
  //       setState(() {
  //         loading = false;
  //       });
  //       showMyDialog(
  //           isTrue: false,
  //           context: context,
  //           message: map['message'].toString());
  //     }
  //
  //     // Navigator.pop(context);
  //   } catch (e) {
  //     print('Cash Resster Errro');
  //     setState(() {
  //       loading = false;
  //     });
  //     showMyDialog(
  //       isTrue: false,
  //       context: context,
  //       message: getTranslated(context, 'catchError'),
  //     );
  //
  //     print(e.toString());
  //   }
  // }

  void verificationPhone(context) async {
    int? _resendToken;
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
        phoneNumber:/*"+20 101 211 1111"*/ countryCode+phone,
        verificationCompleted: (phoneAuthCredential) async {
          print(phoneAuthCredential.smsCode);
        },
        timeout: const Duration(seconds: 60),
        verificationFailed: (verificationFailed) async {
          print(verificationFailed.message);
          PhoneCubit.get(context).changeLoadingState(false);
          currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
          // showMyDialog(
          //     isTrue: false,
          //     context: context,
          //     message: verificationFailed.message);
        },
        codeSent: (verificationId, reSendingToken) async {
          _resendToken = reSendingToken;
          print(verificationId);
          if(verificationId.isNotEmpty){
            PhoneCubit.get(context).changeLoadingState(false);
            currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
            this.verificationId = verificationId;
          }
        },
        forceResendingToken: _resendToken,
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = this.verificationId!;
        },

        );
  }

}

enum MobileVerificationState { SHOW_MOBILE_FORM_STATE, SHOW_OTP_FORM_STATE }

