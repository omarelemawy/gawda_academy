import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/routes.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/splashscreen.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'constants/constans.dart';
import 'firebase_options.dart';
import 'localization/app_localization.dart';
import 'localization/localization_constants.dart';
import 'dart:developer';

/*
                    fcm_config
 Show fcm notification while app is in foreground
 Easily receive incoming notification where you are
 Easily receive clicked where you are Notification is an object
*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FCMConfig.instance.init(
      defaultAndroidForegroundIcon: '@mipmap/ic_launcher', //default is @mipmap/ic_launcher
      defaultAndroidChannel: const AndroidNotificationChannel(
        'high_importance_channel',// same as value from android setup
        'Fcm config',
        importance: Importance.high,
        sound: RawResourceAndroidNotificationSound('notification'),
      )
  );
  await FCMConfig.instance.messaging.getToken().then((token) {
    print(token);
    log(token!);
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) async {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // return StreamProvider<ConnectivityStatus>(
    //   initialData: null,
    //   create: (context) =>
    //       ConnectivityService().connectionStatusController.stream,
    //   child:
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryIconTheme: const IconThemeData(color: Colors.white),
        primaryColor: Colors.white,
        bottomAppBarColor: customColor,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 3,
          iconTheme: const IconThemeData(color: customColor),
          actionsIconTheme: const IconThemeData(color: customColor),
          centerTitle: true,
          textTheme: TextTheme(
            headline6: AppTheme.subHeadingColorBlue.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        accentColor: customColor,
        iconTheme: const IconThemeData(color: customColor),
      ),
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('ar', 'EG'),
      ],
      locale: _locale,
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale!.languageCode &&
              locale.countryCode == deviceLocale.countryCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
      initialRoute: SplashScreen.route,
      routes: routes,
      // ),
    );
  }
}
