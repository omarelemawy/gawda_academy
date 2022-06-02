import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/categoriesApi.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/utils.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/CategoriesCourses/categoriesCoursesPageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../models/InstructorApi.dart';

class CategoriesCoursesPage extends StatefulWidget {
  final String? name;
  final int? id;

  const CategoriesCoursesPage({Key? key, this.name, this.id}) : super(key: key);
  @override
  _CategoriesCoursesPageState createState() => _CategoriesCoursesPageState();
}

class _CategoriesCoursesPageState extends State<CategoriesCoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: CategoriesApi.fetchCategrsCoursesByid(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data as List<CouresesModels>;
            return (snapshot.data==null)
                ? Container()
                : ListView(
                    shrinkWrap: true,
                    primary: true,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    children: [
                      Text(
                        widget.name.toString(),
                        style: AppTheme.headingColorBlue.copyWith(
                          fontSize: 20,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: data.length,
                        padding:EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => CategoriesCoursesPageView(
                                        courses: data[index])
                                    // CategoriesCoursesPageView(
                                    //   courses: snapshot.data[index],
                                    // ),
                                    ),
                              );
                            },
                            child: Column(
                              children: [
                                Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: 100,
                                        width: 120,
                                        decoration: BoxDecoration(),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: customCachedNetworkImage(
                                            context: context,
                                            boxFit: BoxFit.cover,
                                            url:
                                                data[index].image_path,
                                          ),
                                        )),
                                    SizedBox(width: 10),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index].name!,
                                            style: AppTheme.headingColorBlue
                                                .copyWith(
                                              fontSize: 12,
                                            ),
                                          ),
                                          (data[index]
                                                      .instructorName ==
                                                  null)
                                              ? Container()
                                              : Text(
                                                  data[index]
                                                      .instructorName!,
                                                  style: AppTheme.subHeading
                                                      .copyWith(
                                                    color: customColorGold,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                          (data[index].rate == '0')
                                              ? Container()
                                              : Row(
                                                  children: [
                                                    RatingStar(
                                                      rating: double.parse(
                                                          data[index]
                                                              .rate!),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      data[index].rate
                                                          .toString(),
                                                      style: AppTheme.subHeading
                                                          .copyWith(
                                                        fontSize: 10,
                                                        color: customColorGold,
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      '(${data[index].rate_count})',
                                                      style: AppTheme.subHeading
                                                          .copyWith(
                                                        fontSize: 10,
                                                        color: customColorGold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          SizedBox(height: 10),
                                          Container(
                                            width: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Utils.bageColors(
                                                bage:
                                                    data[index].badges,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                data[index].badges
                                                    .toString()
                                                    .toUpperCase(),
                                                maxLines: 1,
                                                style: AppTheme
                                                    .subHeadingColorBlue
                                                    .copyWith(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // SizedBox(
                                          //                                           //   width: 180,
                                          //                                           //   height: 22,
                                          //                                           //   child: ListView(
                                          //                                           //     scrollDirection: Axis.horizontal,
                                          //                                           //     children: course.badges.split(",").map((e) =>
                                          //                                           //         Container(
                                          //                                           //           margin: EdgeInsets.symmetric(horizontal: 5),
                                          //                                           //           padding: EdgeInsets.symmetric(horizontal: 5),
                                          //                                           //           decoration: BoxDecoration(
                                          //                                           //             borderRadius:
                                          //                                           //             BorderRadius.circular(10),
                                          //                                           //             color: Utils.bageColors(
                                          //                                           //               bage: e,
                                          //                                           //               //course.badges,
                                          //                                           //             ),
                                          //                                           //           ),
                                          //                                           //           child: Center(
                                          //                                           //             child: Text(
                                          //                                           //
                                          //                                           //               e.toUpperCase(),
                                          //                                           //               maxLines: 1,
                                          //                                           //
                                          //                                           //               style: AppTheme
                                          //                                           //                   .subHeadingColorBlue
                                          //                                           //                   .copyWith(
                                          //                                           //                 color: Colors.white,
                                          //                                           //               ),
                                          //                                           //             ),
                                          //                                           //           ),
                                          //                                           //         )).toList(),
                                          //                                           //
                                          //                                           //
                                          //                                           //   ),
                                          //                                           // ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              //SizedBox(width: 10),
                                              (data[index].discount ==
                                                          null ||
                                                      data[index]
                                                              .discount ==
                                                          '')
                                                  ? Container()
                                                  : Text(
                                                      newPrice(
                                                        price: double.parse(
                                                            data[index]
                                                                .price!),
                                                        dis: double.parse(
                                                          data[index]
                                                              .discount!,
                                                        ),
                                                      ).toString(),
                                                      style: AppTheme
                                                          .headingColorBlue
                                                          .copyWith(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                              SizedBox(width: 7),
                                              Text(
                                                '${data[index].price} ' +
                                                    getTranslated(
                                                        context, 'KD').toString(),
                                                style: (data[index]
                                                                .discount ==
                                                            null ||
                                                        data[index]
                                                                .discount ==
                                                            '')
                                                    ? AppTheme.headingColorBlue
                                                        .copyWith(
                                                        fontSize: 12,
                                                        color: customColor,
                                                      )
                                                    : AppTheme.headingColorBlue
                                                        .copyWith(
                                                            fontSize: 12,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            color: customColor
                                                                .withOpacity(
                                                                    .5),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );
          } else {
            return Center(
              child: SpinKitChasingDots(
                color: customColor,
                size: 20,
              ),
            );
          }
        },
      ),
    );
  }
}
