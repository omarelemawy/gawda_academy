import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/InstructorApi.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/pdffileRequest/mycoursePDFfiles.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/prodact.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/userData.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/my%20courses/components/videoscreens.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/my%20courses/mycoursesdetails.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/wrapper/wrapper.dart';
import 'package:elgawda_by_shay_b_haleb_new/services/dbhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriesCoursesPageView extends StatefulWidget {
  final CouresesModels courses;

  const CategoriesCoursesPageView({required this.courses});

  @override
  _CategoriesCoursesPageViewState createState() =>
      _CategoriesCoursesPageViewState();
}

class _CategoriesCoursesPageViewState extends State<CategoriesCoursesPageView> {
  DbHehper? helper;
  bool cantAdd = false;
  var courseFromSQL;
  bool loading = false;

  getCouresByIdFlomSQl() async {
    courseFromSQL = await helper!.getProductById(widget.courses.id!);

    if (courseFromSQL != null) {
      if (courseFromSQL.coursesId == widget.courses.id) {
        setState(() {
          cantAdd = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    helper = DbHehper();
    print("vimeo_code: ${widget.courses.vimeo_code}");
    getCouresByIdFlomSQl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courses.name!),
      ),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        children: [
          (widget.courses.vimeo_code != '' && widget.courses.vimeo_code != null)
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 160,
                  child: ChewieVideo(
                    // url: snapshot.data,
                    videoCode: widget.courses.vimeo_code!,
                  ),
                )
              // FutureBuilder(
              //     future: CategoriesApi.getVideoMp4Link(
              //         id: widget.courses.vimeo_code),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         print(snapshot.data);
              //         return (snapshot.data == null || snapshot.data.isEmpty)
              //             ? Container()
              //             : Container(
              //                 width: MediaQuery.of(context).size.width,
              //                 height: 200,
              //                 child: ChewieVideo(
              //                   url: snapshot.data,
              //                   videoCode: widget.courses.vimeo_code,
              //                 ),
              //               );
              //       } else {
              //         return Center(
              //           child: SpinKitChasingDots(
              //             color: customColor,
              //             size: 20,
              //           ),
              //         );
              //       }
              //     },
              //   )
              : Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: customCachedNetworkImage(
                      boxFit: BoxFit.cover,
                      context: context,
                      url: widget.courses.image_path,
                    ),
                  ),
                ),
          ListView(
            shrinkWrap: true,
            primary: false,
            //S padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      // getTranslated(context, 'Courses') +
                      " " + widget.courses.name!,
                      style: AppTheme.headingColorBlue.copyWith(
                        color: customColorGold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RatingStar(
                          rating: double.parse(widget.courses.rate!),
                        ),
                        SizedBox(width: 5),
                        Text(
                          widget.courses.rate.toString(),
                          style: AppTheme.subHeading.copyWith(
                            fontSize: 10,
                            color: customColorGold,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '(${widget.courses.rate_count})',
                          style: AppTheme.subHeading.copyWith(
                            fontSize: 10,
                            color: customColorGold,
                          ),
                        ),
                        Spacer(),
                        // (widget.courses.enrolled == 1)
                        //     ?
                        (widget.courses.discount == null ||
                                widget.courses.discount == '')
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.courses.price!,
                                    style: AppTheme.headingColorBlue.copyWith(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.courses.price!,
                                    style: AppTheme.headingColorBlue.copyWith(
                                        fontSize: 12,
                                        decoration: TextDecoration.lineThrough,
                                        color: customColor.withOpacity(.5),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                      newPrice(
                                              price: double.parse(
                                                  widget.courses.price!),
                                              dis: double.parse(
                                                  widget.courses.discount!))
                                          .toString(),
                                      style: AppTheme.headingColorBlue
                                          .copyWith(fontSize: 12)),
                                ],
                              )
                        // : SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // (widget.courses.instructorName == '' ||
                //     widget.courses.instructorName == null)
                //     ? Container()
                //     : coursesDetaile(
                //   iconData: Icons.person,
                //   title: getTranslated(context, 'Createdby') +
                //       ' ' +
                //       widget.courses.instructorName,
                // ),
                // SizedBox(height: 10),
                // (widget.courses.total_time == '00:00:00' ||
                //     widget.courses.total_time == null)
                //     ? Container()
                //     : coursesDetaile(
                //   iconData: Icons.play_circle_fill,
                //   title: '${widget.courses.total_time} ' +
                //       getTranslated(context, 'total_hours_video'),
                // ),
                (widget.courses.total_files == 0 ||
                        widget.courses.total_files == null)
                    ? Container()
                    : InkWell(
                        onTap: () {
                          myBottomSheet(context, widget.courses.sections);
                        },
                        child: coursesDetaile(
                          iconData: FontAwesomeIcons.book,
                          title:
                              '${widget.courses.total_files} ${getTranslated(context, 'Of')} PDF',
                        ),
                      )
                // SizedBox(height: 10),
                // (widget.courses.total_quizes == 0 ||
                //     widget.courses.total_quizes == null)
                //     ? Container()
                //     : coursesDetaile(
                //   iconData: Icons.book,
                //   title:
                //   '${widget.courses.total_quizes} ${getTranslated(context, 'Quizes')}',
                // ),
                // SizedBox(height: 30),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: customColorbottomBar.withOpacity(.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    getTranslated(context, 'about').toString() + " " + widget.courses.name!,
                    style: AppTheme.heading.copyWith(
                      color: customColorGray,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    parseHtmlString((widget.courses.description!)),
                    style: AppTheme.subHeading.copyWith(
                      color: customColorGray,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (loading)
                  ? Center(
                      child: SpinKitChasingDots(
                        color: customColor,
                        size: 20,
                      ),
                    )
                  : (widget.courses.enrolled == 0)
                      ? iconCouresBoton(
                          icon: Icons.favorite,
                          title: (widget.courses.in_wish_list == 0)
                              ? getTranslated(context, 'add_to_wishlist').toString()
                              : getTranslated(context, 'remove_to_wishlist').toString(),
                          onTap: () {
                            setState(() {
                              loading = !loading;
                            });
                            addToWishList();
                          },
                        )
                      : SizedBox(),
              (widget.courses.enrolled == 1)
                  ? iconCouresBoton(
                      title: getTranslated(context, 'goto_course').toString(),
                      icon: FontAwesomeIcons.youtube,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => MyCoursesDetails(
                              courses: widget.courses,
                            ),
                          ),
                        );
                      })
                  : (cantAdd)
                      ? SizedBox()
                      : iconCouresBoton(
                          icon: FontAwesomeIcons.shoppingCart,
                          title: getTranslated(context, 'add_to_cart').toString(),
                          onTap: () async {
                            setState(() {
                              increaseCartTotlaPrice(
                                price: (widget.courses.discount == null)
                                    ? double.parse(
                                        widget.courses.price.toString())
                                    : newPrice(
                                        dis: double.parse(
                                            widget.courses.discount.toString()),
                                        price: double.parse(
                                          widget.courses.price.toString(),
                                        ),
                                      ),
                              );
                            });
                            CoursesProdect prodect = CoursesProdect({
                              'CoursesId': widget.courses.id,
                              'title': widget.courses.name,
                              'price': (widget.courses.discount == null)
                                  ? double.parse(
                                      widget.courses.price.toString())
                                  : newPrice(
                                      dis: double.parse(
                                          widget.courses.discount.toString()),
                                      price: double.parse(
                                        widget.courses.price.toString(),
                                      ),
                                    ),
                              'proImageUrl': widget.courses.image_path,
                            });
                            // ignore: unused_local_variable
                            int id = await helper!.createProduct(prodect);
                            cardDialog(
                                context: context, message: 'Item Was Add');
                          },
                        ),
              iconCouresBoton(
                icon: FontAwesomeIcons.solidShareSquare,
                title: getTranslated(context, 'share').toString(),
                onTap: () {
                  share(
                    url: widget.courses.website_link,
                    title: widget.courses.name!,
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 30),
          (widget.courses.sections.isEmpty)
              ? Container()
              : ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: widget.courses.sections.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        widget.courses.sections[index]['lessons'].isEmpty
                            ? Container()
                            : ListTile(
                                title: Text(
                                  (widget.courses.sections[index]['name']) ??
                                      '',
                                  style: AppTheme.headingColorBlue,
                                ),
                                subtitle: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Video -${widget.courses.sections[index]['featured_data']["total_time"]} mins-',
                                        style: AppTheme.subHeading.copyWith(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Resources (${widget.courses.sections[index]['featured_data']["total_files"]})',
                                        style: AppTheme.subHeading.copyWith(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        widget.courses.sections[index]['lessons'].isEmpty
                            ? Container()
                            : Container(
                                // color: customColorbottomBar,
                                child: lectureDetaile(
                                    list: widget.courses.sections[index]
                                        ['lessons']),
                              ),
                      ],
                    );
                  },
                ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  coursesDetaile({IconData? iconData, String? title}) {
    return Row(
      children: [
        Icon(
          iconData,
          color: customColorGold,
        ),
        SizedBox(width: 10),
        Text(
          title.toString(),
          style: AppTheme.heading.copyWith(
            color: customColorGray,
          ),
        )
      ],
    );
  }

  lectureDetaile({var list}) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: list.length,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${index + 1}',
                  style: AppTheme.heading.copyWith(
                    fontSize: 25,
                  ),
                ),
                SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 110,
                          child: Text(
                            list[index]['name'],
                            style: AppTheme.heading,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Video -${list[index]["duration"]}',
                      style: AppTheme.subHeading.copyWith(
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              color: customColorDivider,
              thickness: 1,
            ),
          ],
        );
      },
    );
  }

  iconCouresBoton({String? title, IconData? icon, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: customColor,
            size: 35,
          ),
          SizedBox(height: 10),
          Text(
            (title) ?? '',
            textAlign: TextAlign.center,
            style: AppTheme.headingColorBlue.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  addToWishList() async {
    try {
      var response = await http.post(
        Utils.MyWishList_URL,
        body: {
          'course_id': widget.courses.id.toString(),
        },
        headers: {
          'x-api-key': UserApp.userToken.toString(),
          'lang': apiLang(),
        },
      );
      print(response.statusCode);

      Map<String, dynamic> map = json.decode(response.body);
      print(map);
      if (map['success'] == false) {
        setState(() {
          loading = !loading;
        });
        showMyDialog(
          isTrue: false,
          context: context,
          message: map['message'].toString(),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => Wrapper(),
              ),
            );
          },
        );
      } else {
        setState(() {
          loading = !loading;
        });
        showMyDialog(
          isTrue: true,
          context: context,
          message: (widget.courses.in_wish_list == 1)
              ? getTranslated(context, 'removeCourse')
              : getTranslated(context, 'addCourse'),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => Wrapper(
                  index: 2,
                ),
              ),
            );
          },
        );
      }
    } catch (e) {
      setState(() {
        loading = !loading;
      });
      showMyDialog(
        isTrue: false,
        context: context,
        message: getTranslated(context, 'catchError'),
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => Wrapper(),
            ),
          );
        },
      );
      print('whtis List errororororr');
      print(e.toString());
    }
  }
}
