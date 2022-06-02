import 'package:carousel_slider/carousel_slider.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/HomeDataApi.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/InstructorApi.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/CategoriesCourses/categoriesCoursesPageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Container sectionTitle(
    {String? title, Function()? onTap, required BuildContext context}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            title!,
            style: AppTheme.headingColorBlue.copyWith(fontSize: 16),
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            getTranslated(context, 'view_all')!,
            style: AppTheme.subHeading.copyWith(
              fontSize: 12,
              color: customColorGold,
            ),
          ),
        ),
      ],
    ),
  );
}

//////////////////////////////////////////////////////////////////////
featuredSections({required BuildContext context}) {
  return FutureBuilder(
    future: HomeDaTaApi.fetchFeaturedCourses(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        print(snapshot.data);
        var data =snapshot.data as List<CouresesModels>;
        return (snapshot.data == null || data.isEmpty)
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      getTranslated(context, 'featured')!,
                      style: AppTheme.headingColorBlue.copyWith(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return featuerd(
                          index: index,
                          coures: data[index],
                          context: context,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => CategoriesCoursesPageView(
                                  courses: data[index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
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
  );
}

//////////////////////////////////////////////////////////////////////

featuerd({
  int? index,
  Function()? onTap,
  required BuildContext context,
  CouresesModels? coures,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 180,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: customCachedNetworkImage(
                context: context,
                boxFit: BoxFit.cover,
                url: coures!.image_path,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              (coures.name!),
              style: AppTheme.headingColorBlue.copyWith(fontSize: 12),
            ),
          ),
          (coures.instructorName == null)
              ? Container()
              : Text(
                  (coures.instructorName!) ,
                  style: AppTheme.subHeading.copyWith(
                    fontSize: 10,
                    color: customColorGold,
                  ),
                ),
          (coures.rate == '0')
              ? Container()
              : Row(
                  children: [
                    RatingStar(
                      rating: double.parse(coures.rate!),
                    ),
                    SizedBox(width: 5),
                    Text(
                      '${coures.rate}',
                      style: AppTheme.subHeading.copyWith(
                        fontSize: 10,
                        color: customColorGold,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      '(${coures.rate_count})',
                      style: AppTheme.subHeading.copyWith(
                        fontSize: 10,
                        color: customColorGold,
                      ),
                    ),
                  ],
                ),
          Row(
            children: [
              (coures.discount == null || coures.discount == '')
                  ? Container()
                  : Text(
                      newPrice(
                        price: double.parse(coures.price!),
                        dis: double.parse(
                          coures.discount!,
                        ),
                      ).toString(),
                      style: AppTheme.headingColorBlue.copyWith(fontSize: 12),
                    ),
              SizedBox(width: 7),
              Text(
                '${coures.price} ' + getTranslated(context, 'KD')!,
                style: (coures.discount != null && coures.discount != '')
                    ? AppTheme.headingColorBlue.copyWith(
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                        color: customColor.withOpacity(.5),
                        fontWeight: FontWeight.w400)
                    : AppTheme.headingColorBlue.copyWith(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
//////////////////////////////////////////////////////////////////////

homeSlider(BuildContext context) {
  return FutureBuilder(
    future: HomeDaTaApi.fetchHomeSlider(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        print(snapshot.data);
        var data =snapshot.data as List<CouresesModels>;
        return (snapshot.data == null || data.isEmpty)
            ? Container()
            : coursesSilder(context: context, list: data);
      } else {
        return Center(
          child: SpinKitChasingDots(
            color: customColor,
            size: 20,
          ),
        );
      }
    },
  );
}

//////////////////////////////////////////////////////////////////////
Container coursesSilder({
  required BuildContext context,
  List? list,
}) {
  return Container(
    child: Column(
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            autoPlayInterval: Duration(seconds: 2),
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            viewportFraction: 1,
          ),
          items: list!
              .map(
                (items) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CategoriesCoursesPageView(
                          courses: items,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    height: 300,
                    width: 340,
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          child: Stack(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                child: Container(
                                  width: 500,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  child: customCachedNetworkImage(
                                    context: context,
                                    boxFit: BoxFit.cover,
                                    url: items.image_path,
                                  ),
                                ),
                              ),
                              Container(
                                width: 500,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                                child: Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0),
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(200, 0, 0, 0),
                                        Color.fromARGB(0, 0, 0, 0)
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        items.name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    ),
  );
}

/////////////////////////////
