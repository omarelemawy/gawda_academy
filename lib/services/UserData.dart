import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/userData.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';

import '../sharedPreferences.dart';

class DatabaseServices {
  final String? userToken;
  final BuildContext context;
  final controller = StreamController<Users>();
  Map<String, dynamic>? map;

  DatabaseServices({required this.context, this.userToken});
  gituserData() async {
    try {
      var response = await http
          .get(Utils.GITUSERDATA_URL, headers: {'x-api-key': userToken!});
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(response.statusCode.toString());
        final user = _userFromDatabaseUser(data, context);
        controller.add(user!);
      } else if (response.statusCode == 201) {
        final data = json.decode(response.body);

        final user = _userFromDatabaseUser(data, context);
        controller.add(user!);
      } else {
        print(response.statusCode.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Users? _userFromDatabaseUser(Map user, BuildContext context) {
    return user != null
        ? Users(
            name: user['data']['name'].toString(),
            image: user['data']['image'].toString(),
            userId: user['data']['id'],
            moblie: (user['data']['mobile'] != null)
                ? user['data']['mobile'].toString()
                : '',
            email: user['data']['email'].toString(),
          )
        : null;
  }

  upDateUserData(
      {String? mobile,
      String? password,
      String? name,
      File? images,
      String? email,
      required BuildContext context}) async {
    try {
      var data;
      if (images == null) {
        data = FormData.fromMap({
          "email": '$email',
          'name': "$name",
          'password': "$password",
          'password_confirmation': "$password",
          "image": null,
          'mobile': "$mobile",
        });

        print("dataNull:$data");
      } else {
        String image = images.path.split('/').last;
        data = FormData.fromMap({
          "email": '$email',
          'name': "$name",
          'password': "$password",
          'password_confirmation': "$password",
          "image": await MultipartFile.fromFile(
            images.path,
            filename: image,
          ),
          'mobile': "$mobile",
        });
        print("data:$data");
      }

      Dio dio = new Dio();
      dio.options.headers['x-api-key'] = userToken;

      Response response =
          await dio.post(Utils.UPDATEUSERDATA_URL.toString(), data: data);
      print('response:$response');

      if (response.statusCode == 200) {
        print('response.statusCode:200');
        if (response.data['success'] == true) {
          print('profile: success');
          if (password != UserApp.userPassword) {
            MySharedPreferences.saveUserUserPassword(password!);
          }

          showEDITDialog(
            context: context,
            message: getTranslated(context, 'toeditPro'),
            isTrue: true,
          );
        } else {
          print('profile: false');

          showEDITDialog(
            context: context,
            isTrue: false,
            message: response.data['message'].toString(),
          );
        }
      } else if (response.statusCode == 429) {
        print('profile: 429');

        showEDITDialog(
          isTrue: false,
          context: context,
          message: getTranslated(context, 'failededitPro'),
        );
      } else {
        print('profile: 500');

        showEDITDialog(
          context: context,
          isTrue: false,
          message: getTranslated(context, 'catchError'),
        );
      }
    } catch (e) {
      print('errrrroe Upadata Data');

      showEDITDialog(
        context: context,
        isTrue: false,
        message: getTranslated(context, 'catchError'),
      );

      print(e.toString());
    }
  }

  Stream<Users> get userData {
    print(userToken);
    gituserData();
    return controller.stream;
  }
}

Future<void> showEDITDialog(
    {required BuildContext context, var message,  bool? isTrue}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                (isTrue!)
                    ? Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('lib/images/profiletrue.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(),
                ListBody(
                  children: <Widget>[
                    Center(
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: AppTheme.heading.copyWith(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class Users {
  final int? userId;
  final String? moblie;
  final String? name;
  final String? image;
  final String? email;

  Users({
    this.image,
    this.name,
    this.email,
    this.moblie,
    this.userId,
  });
}
