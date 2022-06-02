import 'dart:convert';
import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../userData.dart';
import '../utils.dart';

List resources = [];

getPdffiles() async {
  try {
    var response = await http.get(
      Utils.MyCourses_URL,
      headers: {
        'x-api-key': UserApp.userToken.toString(),
      },
    );

    var data = json.decode(response.body);
    for (var item in data['data']['sections']) {
      for (var item2 in item['lessons']) {
        resources.add(item2);
      }
    }

    return resources;
  } catch (error) {
    print(
        "pdf files  ------------------------------------------------------------------- ${error.toString()}");
  }
}
void _launchUrl(_url) async {
  if (!await launchUrl(_url)) throw 'Could not launch $_url';
}
void myBottomSheet(context, List resources) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Container(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () async {
                    Uri uri=Uri.parse(resources[0]['lessons'][0]['resources']
                    [0]['file_path']);
                    _launchUrl(uri);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.book,
                          color: customColorGold,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "${resources[0]['lessons'][0]['resources'][0]['name']}",
                          style: AppTheme.heading
                              .copyWith(color: customColorGray, fontSize: 16),
                        )
                      ],
                    ),
                  ));
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: resources.length,
          ),
        );
      });
}
