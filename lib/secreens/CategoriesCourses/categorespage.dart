import 'package:elgawda_by_shay_b_haleb_new/models/categoriesApi.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/CategoriesCourses/categoriesCoursesPage.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/CategoriesCourses/subCategoriesCourses.dart';
import 'package:flutter/material.dart';

class Categorespage extends StatefulWidget {
  final List<SubCategoriesModels> categores;
  final String name;
  final int id;

  const Categorespage(
      {Key? key,
      required this.categores,
      required this.name,
      required this.id})
      : super(key: key);
  @override
  _CategorespageState createState() => _CategorespageState();
}

class _CategorespageState extends State<Categorespage> {
  @override
  Widget build(BuildContext context) {
    if (widget.categores.isEmpty) {
      return CategoriesCoursesPage(
        id: widget.id,
        name: widget.name,
      );
    } else {
      return SubCategoriesCourses(
        subCategores: widget.categores,
      );
    }
  }
}
