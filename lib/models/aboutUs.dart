import 'dart:convert';
// import 'package:elgawda/models/userData.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/utils.dart';
import 'package:http/http.dart' as http;

class AboutUS {
   String? imageUrl;
   String? contant;
  AboutUS({ this.imageUrl,  this.contant});

}

class AboutUSApi {
  static Future<AboutUS?> gitAboutUSApi() async {
    AboutUS? aboutUS;
    var response = await http.get(
      Utils.AboutUS_URL,
      // headers: {
      //   'lang': User.apiLang,
      // },
    );
    var jsonData = json.decode(response.body);
    print(jsonData);
    print(response.statusCode.toString());
    try {
      if (response.statusCode == 200) {
        print('succ:' + response.statusCode.toString());
        aboutUS = AboutUS(
          imageUrl: jsonData['data']['image'],
          contant: jsonData['data']['text'],
        );
      } else if (response.statusCode == 201) {
        print('succ1:' + response.statusCode.toString());
        aboutUS = AboutUS(
          imageUrl: jsonData['data']['image'],
          contant: jsonData['data']['text'],
        );
      } else {
        print('error');
      }
    } catch (e) {
      print('cath:' + response.statusCode.toString());
      print(e.toString());
    }
    return aboutUS;
  }
}
