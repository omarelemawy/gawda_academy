import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/userData.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationsModels {
  final String? title;
  final String? body;
  // ignore: non_constant_identifier_names
  final String? created_at;

  // ignore: non_constant_identifier_names
  NotificationsModels({required this.title, required this.body, required this.created_at});
}

class NotificationsApi {
  static Future<List<NotificationsModels>>? fetchAllMyNotifications() async {
    List<NotificationsModels>? listOfNotifications = [];

    try {
      var response = await http.get(Utils.Notifications_URL, headers: {
        'x-api-key': UserApp.userToken.toString(),
        'lang': apiLang(),
      });
      var jsonData = json.decode(response.body);
      print(jsonData);
      if (response.statusCode == 200) {
        for (var cours in jsonData['data']) {
          NotificationsModels notifications = NotificationsModels(
            title: cours['title'],
            body: cours['body'],
            created_at: cours['created_at'],
          );
          listOfNotifications.add(notifications);
        }
      }
    } catch (e) {
      print('Caht errror');

      print(e);
    }
    return listOfNotifications;
  }
}
