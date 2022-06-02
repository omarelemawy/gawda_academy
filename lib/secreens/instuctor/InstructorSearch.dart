import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/InstructorApi.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/instuctor/instructorPageView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class InstructorSearch extends SearchDelegate {
  InstructorSearch()
      : super(
            searchFieldLabel: 'search_instructor',
            searchFieldStyle: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontFamily: 'Cairo-SemiBold'));
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          close(context, null);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return query.isEmpty
        ? Container()
        : FutureBuilder(
            future: InstructorSearchApi.instructorSearch(query),
            builder: (context,AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return (snapshot.data == null || snapshot.data.isEmpty)
                    ? Container(
                        child: Center(
                          child: Text(getTranslated(context, "searchFiled")!),
                        ),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: customColor),
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  child: (snapshot.data[i].image_path == null)
                                      ? Container(
                                          child: Icon(
                                            Icons.image,
                                            color: Colors.lightBlueAccent,
                                          ),
                                        )
                                      : customCachedNetworkImage(
                                          context: context,
                                          url: snapshot.data[i].image_path,
                                          boxFit: BoxFit.cover)),
                            ),
                            title: Column(
                              children: [
                                Text(snapshot.data[i].name),
                                (snapshot.data[i].bio == null)
                                    ? Container()
                                    : Text(snapshot.data[i].bio),
                                (snapshot.data[i].job == null)
                                    ? Container()
                                    : Text(snapshot.data[i].job),
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => InstructorPageView(
                                      instructor: snapshot.data[i]),
                                ),
                              );
                            },
                          );
                        },
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

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? Container()
        : FutureBuilder(
            future: InstructorSearchApi.instructorSearch(query),
            builder: (context,AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return (snapshot.data == null || snapshot.data.isEmpty)
                    ? Container(
                        child: Center(
                          child: Text(getTranslated(context, "searchFiled")!),
                        ),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: customColor),
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  child: (snapshot.data[i].image_path == null)
                                      ? Container(
                                          child: Icon(
                                            Icons.image,
                                            color: Colors.lightBlueAccent,
                                          ),
                                        )
                                      : customCachedNetworkImage(
                                          context: context,
                                          url: snapshot.data[i].image_path,
                                          boxFit: BoxFit.cover)),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data[i].name,
                                  style: AppTheme.headingColorBlue,
                                ),
                                (snapshot.data[i].bio == null)
                                    ? Container()
                                    : Text(
                                        snapshot.data[i].bio,
                                        style: AppTheme.subHeading,
                                      ),
                                (snapshot.data[i].job == null)
                                    ? Container()
                                    : Text(
                                        snapshot.data[i].job,
                                        style: AppTheme.subHeading,
                                      ),
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => InstructorPageView(
                                  instructor: snapshot.data[i],
                                ),
                              ));
                            },
                          );
                        },
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
}
