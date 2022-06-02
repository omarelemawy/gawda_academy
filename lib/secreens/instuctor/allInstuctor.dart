import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/InstructorApi.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/instuctor/instructorPageView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AllInstuctor extends StatefulWidget {
  @override
  _AllInstuctorState createState() => _AllInstuctorState();
}

class _AllInstuctorState extends State<AllInstuctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.graduationCap,
              color: customColor,
            ),
            SizedBox(width: 20),
            Text(getTranslated(context, 'instructor')!),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.search,
                color: customColorDivider,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Text(
            getTranslated(context, 'instructor')!,
            style: AppTheme.headingColorBlue.copyWith(
              fontSize: 16,
            ),
          ),
          FutureBuilder(
            future: InstructorApi.fetchALLInstructor(),
            builder: (context,AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                return (snapshot.data == null || snapshot.data.isEmpty)
                    ? Container()
                    : ListView.builder(
                    itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        primary: false,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              insructorCard(
                                  index: index,
                                  instructor: snapshot.data[index],
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => InstructorPageView(
                                          instructor: snapshot.data[index],
                                        ),
                                      ),
                                    );
                                  }),
                              Divider(
                                color: customColor.withOpacity(.5),

                              ),
                            ],
                          );
                        },
                      );
              } else {
                return Center(child:SpinKitChasingDots(
                  color: customColor,
                  size: 20,
                ),);
              }
            },
          ),
        ],
      ),
    );
  }

  insructorCard({int? index, Function()? onTap, InstructorModels? instructor}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: customCachedNetworkImage(
                context: context,
                url: instructor!.image_path,
                boxFit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 200,
                height: 20,
                child: Text(
                  (instructor.name!),
                  style: AppTheme.headingColorBlue.copyWith(fontSize: 12),
                ),
              ),
              (instructor.bio == null || instructor.bio == '')
                  ? Container()
                  : SizedBox(
                      width: MediaQuery.of(context).size.width - 200,
                      height: 50,
                      child: Text(
                        (instructor.bio!) ,
                        style: AppTheme.subHeadingColorBlue,
                      ),
                    ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 200,
                height: 50,
                child: Text(
                  (instructor.job!),
                  style: AppTheme.subHeadingColorBlue,
                ),
              ),
            ],
          ),
          Expanded(
            child: Transform.rotate(
              angle: 180 * 3.14 / 180,
              child: Icon(
                Icons.arrow_back_ios,
                color: customColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
