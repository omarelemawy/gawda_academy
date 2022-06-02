import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/main.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/userData.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/about_us/about_us.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/cart/cart.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/contact_us/contact_us..dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/language.dart';

// import 'components/Language.dart';
import '../../sharedPreferences.dart';
import '../splashscreen.dart';
import 'components/moreUserData.dart';
import 'components/morebody.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  UserDate _userDate = UserDate(
    userName: 'Nada Draz',
    userEmail: 'Nada@gmaill.coom',
    userImage: 'lib/images/user.jpg',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(
        context: context,
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            MoreUserData(
              userDate: _userDate,
            ),
            SizedBox(height: 60),
            MoreBody(
              title: getTranslated(context, 'cart'),
              child: Icon(
                FontAwesomeIcons.shoppingCart,
                color: customColor,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => Cart(),
                  ),
                );
              },
            ),
            SizedBox(height: 30),
            MoreBody(
              title: getTranslated(context, 'contact_us'),
              child: Icon(
                FontAwesomeIcons.solidAddressCard,
                color: customColor,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ContactUs(),
                  ),
                );
              },
            ),
            SizedBox(height: 30),
            MoreBody(
              title: getTranslated(context, 'about_us'),
              child: Icon(
                Icons.info_outline,
                size: 30,
                color: customColor,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AboutUs(),
                  ),
                );
              },
            ),
            SizedBox(height: 30),
            lan(),
            Divider(
              color: customColor.withOpacity(.7),
              thickness: 2,
            ),
            SizedBox(height: 50),
            CustomButton(
              onPress: () {
                setState(
                  () {
                    UserApp.userToken = 'null';
                    MySharedPreferences.saveUserUserToken('null');
                  },
                );
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => SplashScreen(),
                  ),
                );
              },
              text: getTranslated(context, 'log_out'),
            ),
          ],
        ),
      ),
    );
  }

  Widget lan() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              getTranslated(context, 'change_language')!,
              style: AppTheme.headingColorBlue,
            ),
          ),
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

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);

    MyApp.setLocale(context, _locale);

    MySharedPreferences.saveAppLang(_locale.toString());
    UserApp.appLang = await MySharedPreferences.getAppLang();
  }
}

/// This is the stateful widget that the main application instantiates.
