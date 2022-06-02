import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/InstructorApi.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/utils.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/CategoriesCourses/categoriesCoursesPageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InstructorPageView extends StatefulWidget {
  final InstructorModels instructor;

  const InstructorPageView({Key? key, required this.instructor})
      : super(key: key);

  @override
  _InstructorPageViewState createState() => _InstructorPageViewState();
}

class _InstructorPageViewState extends State<InstructorPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          instructorImage(),
          (widget.instructor.bio == '' || widget.instructor.bio == null)
              ? Container()
              : Column(
                  children: [
                    Text(
                      getTranslated(context, 'bio')!,
                      textAlign: TextAlign.center,
                      style: AppTheme.headingColorBlue.copyWith(fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(
                        (widget.instructor.bio!),
                        textAlign: TextAlign.center,
                        style:
                            AppTheme.subHeadingColorBlue.copyWith(fontSize: 14),
                      ),
                    ),
                  ],
                ),
          (widget.instructor.courses.isEmpty)
              ? Container()
              : Text(
                  getTranslated(context, 'Training_courses')!,
                  style: AppTheme.headingColorBlue.copyWith(fontSize: 16),
                ),
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: widget.instructor.courses.length,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  trainingCourses(
                    index: index,
                    course: widget.instructor.courses[index],
                    onTap: () {
                      print(widget.instructor.courses[index]);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CategoriesCoursesPageView(
                            courses: widget.instructor.courses[index],
                          ),
                        ),
                      );
                    },
                  ),
                  Divider(
                    color: customColorDivider,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  trainingCourses({int? index, Function()? onTap, CouresesModels? course}) {
    print("course.badges:${course!.badges}");
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 120,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: customCachedNetworkImage(
                    boxFit: BoxFit.cover,
                    context: context,
                    url: course.image_path,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name!,
                    style: AppTheme.headingColorBlue.copyWith(fontSize: 10),
                  ),
                  Text(
                    parseHtmlString(course.description!),
                    style: AppTheme.subHeading.copyWith(
                      fontSize: 10,
                      color: customColorGold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // (course.rate == '0')
                  //     ? Container()
                  //     : Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           RatingStar(
                  //             rating: double.parse(course.rate),
                  //           ),
                  //           SizedBox(width: 5),
                  //           Text(
                  //             '${course.rate}',
                  //             style: AppTheme.subHeading.copyWith(
                  //               fontSize: 10,
                  //               color: customColorGold,
                  //             ),
                  //           ),
                  //           SizedBox(width: 5),
                  //           Text(
                  //             '(${course.rate_count})',
                  //             style: AppTheme.subHeading.copyWith(
                  //               fontSize: 10,
                  //               color: customColorGold,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  Align(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (course.discount == null || course.discount == '')
                            ? Container()
                            : Text(
                                newPrice(
                                  price: double.parse(course.price!),
                                  dis: double.parse(
                                    course.discount!,
                                  ),
                                ).toString(),
                                style: AppTheme.heading.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                        SizedBox(width: 5),
                        Text(
                          '${course.price} ' + getTranslated(context, 'KD')!,
                          style: (course.discount == null ||
                                  course.discount == '')
                              ? AppTheme.heading.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  decoration: (course.discount == null ||
                                          course.discount == '')
                                      ? TextDecoration.none
                                      : TextDecoration.lineThrough,
                                  color: Colors.black,
                                )
                              : AppTheme.heading.copyWith(
                                  fontSize: 12,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 180,
                    height: 22,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: course.badges!
                          .split(",")
                          .map((e) => Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Utils.bageColors(
                                    bage: e,
                                    //course.badges,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    e.toUpperCase(),
                                    maxLines: 1,
                                    style:
                                        AppTheme.subHeadingColorBlue.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  instructorImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(widget.instructor.image_path!),
                  fit: BoxFit.cover)),

          // child: ClipRRect(
          //   borderRadius: BorderRadius.circular(100),
          //   child: customCachedNetworkImage(
          //     context: context,
          //     boxFit: BoxFit.cover,
          //     url: widget.instructor.image_path,
          //   ),
        ),
        // ),
        SizedBox(width: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.instructor.name!,
              textAlign: TextAlign.center,
              style: AppTheme.headingColorBlue.copyWith(fontSize: 14),
            ),
            Text(
              widget.instructor.job!,
              textAlign: TextAlign.center,
              style: AppTheme.subHeadingColorBlue.copyWith(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
