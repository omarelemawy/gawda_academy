import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/categoriesApi.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/CategoriesCourses/categoriesCoursesPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class SubCategoriesCourses extends StatefulWidget {
  final List<SubCategoriesModels>? subCategores;

  const SubCategoriesCourses({Key? key, this.subCategores}) : super(key: key);
  @override
  _SubCategoriesCoursesState createState() => _SubCategoriesCoursesState();
}

class _SubCategoriesCoursesState extends State<SubCategoriesCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        primary: false,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemCount: widget.subCategores!.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CategoriesCoursesPage(
                    name: widget.subCategores![index].name,
                    id: widget.subCategores![index].id,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: customCachedNetworkImage(
                        boxFit: BoxFit.cover,
                        context: context,
                        url: widget.subCategores![index].image,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 30,
                      width: (MediaQuery.of(context).size.width) * .5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: Colors.black.withOpacity(.4),
                      ),
                      child: Center(
                        child: Text(
                          widget.subCategores![index].name!,
                          textAlign: TextAlign.center,
                          style: AppTheme.heading.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        staggeredTileBuilder: (int index) =>
             StaggeredTile.count(2, index.isEven ? 1.5 : 2.0),
      ),
    );
  }
}
