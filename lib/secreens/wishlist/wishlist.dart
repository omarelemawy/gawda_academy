import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/MyCoursesApi.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/CategoriesCourses/categoriesCoursesPageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(
        context: context,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.graduationCap,
              color: customColor,
            ),
            SizedBox(width: 20),
            Text(
              getTranslated(context, 'wishlist')!,
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: MyCoursesApi.fetchMyWishList(),
        builder: (context,AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return (snapshot.data.isEmpty)
                ? Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: customColor,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.favorite,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            getTranslated(context, 'wishlist_empty')!,
                            style: AppTheme.headingColorBlue,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView(
                    shrinkWrap: true,
                    primary: true,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => CategoriesCoursesPageView(
                                    courses: snapshot.data[index],
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: customCachedNetworkImage(
                                          context: context,
                                          boxFit: BoxFit.cover,
                                          url: snapshot.data[index].image_path,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data[index].name,
                                          style: AppTheme.headingColorBlue,
                                        ),
                                        Text(
                                          (snapshot.data[index]
                                                  .instructorName) ??
                                              '',
                                          style: AppTheme.subHeadingColorBlue,
                                        ),
                                        (snapshot.data[index].rate == "0")
                                            ? Container()
                                            : Row(
                                                children: [
                                                  RatingStar(
                                                    rating: double.parse(
                                                        snapshot
                                                            .data[index].rate),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    '${snapshot.data[index].rate}',
                                                    style: AppTheme.subHeading
                                                        .copyWith(
                                                      fontSize: 10,
                                                      color: customColorGold,
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    '(${snapshot.data[index].rate_count})',
                                                    style: AppTheme.subHeading
                                                        .copyWith(
                                                      fontSize: 10,
                                                      color: customColorGold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Divider(
                                  color: customColorDivider,
                                  thickness: 2,
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );
          } else {
            return Center(child:SpinKitChasingDots(
              color: customColor,
              size: 20,
            ),);
          }
        },
      ),
    );
  }
}
