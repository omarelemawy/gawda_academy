import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsContant extends StatelessWidget {
  const NotificationsContant({
    Key? key,
    @required this.title,
    @required this.contant,
    @required this.date,
    @required this.onTap,
  }) : super(key: key);

  final String? title;
  final String? contant;
  final String? date;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: customColor,
              ),
              child: Center(
                child: Icon(
                  Icons.notifications,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 110,
                  child: Text(
                    title!,
                    style: AppTheme.headingColorBlue.copyWith(
                      fontSize: 10,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 110,
                  child: Text(
                    contant!,
                    style: AppTheme.subHeading.copyWith(
                      fontSize: 10,
                    ),
                  ),
                ),
                Text(
                  date!,
                  style: AppTheme.subHeading.copyWith(
                    color: customColorGold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
