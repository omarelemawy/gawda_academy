import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/userData.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MessageModels {
  final int? id;
  final String? message;
  final String? sender;
  // ignore: non_constant_identifier_names
  final String? created_at;

  // ignore: non_constant_identifier_names
  MessageModels({required this.id, required this.message, required this.sender,
    required this.created_at});
}

class ChatApi {
  static Future<List<MessageModels>> fetchAllMyMassege(int id) async {
    List<MessageModels> listOfMessage = [];

    try {
      var response = await http
          .get(Uri.parse(Utils.Chat_URL.toString() + '/$id'), headers: {
        'x-api-key': UserApp.userToken.toString(),
        'lang': apiLang(),
      });
      var jsonData = json.decode(response.body);
      print(jsonData);
      if (response.statusCode == 200) {
        for (var cours in jsonData['data']) {
          MessageModels message = MessageModels(
            id: cours['id'],
            message: cours['message'],
            sender: cours['sender'],
            created_at: cours['created_at'],
          );
          listOfMessage.add(message);
        }
      }
    } catch (e) {
      print('Caht errror');

      print(e);
    }
    return listOfMessage;
  }

  static Future<List<MessageModels>> fetchAllContactUSMessages() async {
    List<MessageModels> listOfMessage = [];

    try {
      var response = await http.get(
          Uri.parse(Utils.Contactus_URL.toString() + '/get_messages'),
          headers: {
            'x-api-key': UserApp.userToken.toString(),
            'lang': apiLang(),
          });
      var jsonData = json.decode(response.body);
      print(jsonData);
      if (response.statusCode == 200) {
        for (var cours in jsonData['data']) {
          MessageModels message = MessageModels(
            id: cours['id'],
            message: cours['message'],
            sender: cours['from'],
            created_at: cours['created_at'],
          );
          listOfMessage.add(message);
        }
      }
    } catch (e) {
      print('Caht errror');

      print(e);
    }
    return listOfMessage;
  }
}
