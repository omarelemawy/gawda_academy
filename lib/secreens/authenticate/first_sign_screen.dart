import 'package:elgawda_by_shay_b_haleb_new/secreens/authenticate/logIn/login.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/authenticate/register/phon_verification_screen.dart';
import 'package:flutter/material.dart';

import '../../constants/constans.dart';
import '../../constants/themes.dart';
import '../../localization/localization_constants.dart';
import '../../main.dart';
import '../../models/language.dart';
import '../../models/userData.dart';
import '../../sharedPreferences.dart';

class FirstSignScreen extends StatefulWidget {
   FirstSignScreen({Key? key}) : super(key: key);
   Function? toggleView;
  @override
  _FirstSignScreenState createState() => _FirstSignScreenState();
}

class _FirstSignScreenState extends State<FirstSignScreen> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        toolbarHeight: 0,
      ),
      body:  Container(
        child: ListView(
          shrinkWrap: true,
          primary: true,
          padding:
          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            SizedBox(height: 20),
            lan(),
            LogoContainar(),

            SizedBox(height: 130),
            Row(
              children: [
                Text(
                  getTranslated(context, 'Welcome')!,
                  style: AppTheme.heading.copyWith(
                    color: customColorGold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  getTranslated(context, 'To Gawda Academy')!,
                  style: AppTheme.heading.copyWith(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    children: [
                      Material(
                        elevation: 6,
                        borderRadius: BorderRadius.circular(10),
                        color: customColor,
                        child: MaterialButton(
                          onPressed:
                              (){
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => LogIn(
                                        toggleView: widget.toggleView,
                                      ),
                                    ),(c)=>false);
                              },
                          minWidth: width,
                          height: 48,
                          child: Text(
                            getTranslated(context, "sign_in")!,
                            style: AppTheme.heading.copyWith(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Material(
                        elevation: 6,
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        child: MaterialButton(
                          onPressed: (){
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PhoneVerification(
                                    toggleView: widget.toggleView,
                                  ),

                                ),(c)=>false);
                          },
                          minWidth: width,
                          height: 48,
                          child: Text(
                            getTranslated(context, "sign_up")!,
                            style: AppTheme.heading.copyWith(
                              fontSize: 14,
                              color:customColor ,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );

  }

}

