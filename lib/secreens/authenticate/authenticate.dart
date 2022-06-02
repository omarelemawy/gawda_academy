import 'package:elgawda_by_shay_b_haleb_new/models/userData.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/authenticate/register/phon_verification_screen.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/authenticate/register/register.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/wrapper/wrapper.dart';
import 'package:flutter/material.dart';

import 'first_sign_screen.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (UserApp.userToken == 'null') {
      if (showSignIn) {
        return Scaffold(
          body: Container(
            child: FirstSignScreen(),
          ),
        );
      } else {
        return Scaffold(
          body: Container(
            child: FirstSignScreen(),
          ),
        );
      }
    } else {
      return Wrapper();
    }
  }
}
