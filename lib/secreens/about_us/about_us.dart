import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/aboutUs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getTranslated(context, "about_us").toString(),
        ),
      ),
      body: FutureBuilder(
        future: AboutUSApi.gitAboutUSApi(),
        builder: (context,AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: SpinKitChasingDots(
                  color: customColor,
                  size: 20,
                ),
              ),
            );
          } else {
            return ListView(
              shrinkWrap: true,
              primary: true,
              children: [
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: snapshot.data!.imageUrl == null
                      ? Container(
                          child: Icon(
                            Icons.image,
                            color: Colors.lightBlueAccent,
                          ),
                        )
                      : customCachedNetworkImage(
                          boxFit: BoxFit.cover,
                          context: context,
                          url: snapshot.data!.imageUrl,
                        ),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: HtmlWidget(snapshot.data.contant),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
