import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/InstructorApi.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/prodact.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/my%20courses/components/videoscreens.dart';
import 'package:elgawda_by_shay_b_haleb_new/services/dbhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeaturedCoursesedtails extends StatefulWidget {
  final CouresesModels courses;

  const FeaturedCoursesedtails({Key? key, required this.courses})
      : super(key: key);
  @override
  _FeaturedCoursesedtailsState createState() => _FeaturedCoursesedtailsState();
}

class _FeaturedCoursesedtailsState extends State<FeaturedCoursesedtails> {
  DbHehper? helper;
  bool cantAdd = false;
  var courseFromSQL;
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
    getCouresByIdFlomSQl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        children: [
          (widget.courses.vimeo_code != '' && widget.courses.vimeo_code != null)
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
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
              //                   // url: snapshot.data,
              //                   videoCode: widget.courses.vimeo_code,
              //                 ),
              //               );
              //       } else {
              //         return Center(
              //             child: SpinKitChasingDots(
              //           color: customColor,
              //           size: 20,
              //         ));
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
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
              Text(
                getTranslated(context, 'Courses')! + ' ' + widget.courses.name!,
                style: AppTheme.headingColorBlue.copyWith(
                  color: customColorGold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                parseHtmlString(widget.courses.description!),
                textAlign: TextAlign.justify,
                style: AppTheme.subHeading.copyWith(
                  color: customColorGray,
                ),
              ),
              SizedBox(height: 20),
              (widget.courses.rate == '0')
                  ? Container()
                  : Row(
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
                      ],
                    ),
              SizedBox(height: 20),
              Text(
                widget.courses.badges!,
                style: AppTheme.heading.copyWith(
                  color: customColorGold,
                ),
              ),
              SizedBox(height: 10),
              (widget.courses.instructorName == '' ||
                      widget.courses.instructorName == null)
                  ? Container()
                  : coursesDetaile(
                      iconData: Icons.person,
                      title: getTranslated(context, 'Createdby')! +
                          ' ' +
                          widget.courses.instructorName!,
                    ),
              SizedBox(height: 10),
              (widget.courses.total_time == '00:00:00' ||
                      widget.courses.total_time == null)
                  ? Container()
                  : coursesDetaile(
                      iconData: Icons.play_circle_fill,
                      title: '${widget.courses.total_time} ' +
                          getTranslated(context, 'total_hours_video')!,
                    ),
              SizedBox(height: 10),
              (widget.courses.total_files == 0 ||
                      widget.courses.total_files == null)
                  ? Container()
                  : coursesDetaile(
                      iconData: FontAwesomeIcons.book,
                      title:
                          '${widget.courses.total_files} ${getTranslated(context, 'Of')} PDF',
                    ),
              SizedBox(height: 10),
              (widget.courses.total_quizes == 0 ||
                      widget.courses.total_quizes == null)
                  ? Container()
                  : coursesDetaile(
                      iconData: Icons.book,
                      title:
                          '${widget.courses.total_quizes} ${getTranslated(context, 'Quizes')}',
                    ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: iconCouresBoton(
                      icon: Icons.favorite,
                      title: getTranslated(context, 'add_to_wishlist')!,
                    ),
                  ),
                  (cantAdd)
                      ? Container()
                      : Expanded(
                          flex: 1,
                          child: iconCouresBoton(
                            icon: FontAwesomeIcons.shoppingCart,
                            title: getTranslated(context, 'add_to_cart')!,
                            onTap: () async {
                              setState(() {
                                increaseCartTotlaPrice(
                                  price: (widget.courses.discount == null)
                                      ? double.parse(
                                          widget.courses.price.toString())
                                      : newPrice(
                                          dis: double.parse(widget
                                              .courses.discount
                                              .toString()),
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
                        ),
                  Expanded(
                    flex: 1,
                    child: iconCouresBoton(
                      onTap: () {
                        share(
                          url: widget.courses.website_link,
                          title: widget.courses.name!,
                        );
                      },
                      icon: FontAwesomeIcons.solidShareSquare,
                      title: getTranslated(context, 'share')!,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        'Pri',
                        style: AppTheme.headingColorBlue.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 10),
                      (widget.courses.discount == null ||
                              widget.courses.discount == '')
                          ? Container()
                          : Text(
                              newPrice(
                                price: double.parse(widget.courses.price!),
                                dis: double.parse(
                                  widget.courses.discount!,
                                ),
                              ).toString(),
                              style: AppTheme.headingColorBlue
                                  .copyWith(fontSize: 12),
                            ),
                      SizedBox(width: 5),
                      Text(
                        '${widget.courses.price}\$',
                        style: (widget.courses.discount == null ||
                                widget.courses.discount == '')
                            ? AppTheme.headingColorBlue.copyWith(
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                                color: customColor.withOpacity(.5),
                              )
                            : AppTheme.headingColorBlue.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Text(
                    widget.courses.discount_message ?? '',
                    style: AppTheme.headingColorBlue.copyWith(
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: customRaiseButtom(
                  text: getTranslated(context, 'enroll_now')!,
                  onTap: () {},
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
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
          title!,
          style: AppTheme.heading.copyWith(
            color: customColorGray,
          ),
        )
      ],
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
            size: 30,
          ),
          SizedBox(height: 10),
          Text(
            title!,
            textAlign: TextAlign.center,
            style: AppTheme.headingColorBlue.copyWith(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
