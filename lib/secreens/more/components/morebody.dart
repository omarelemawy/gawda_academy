import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:flutter/material.dart';

class MoreBody extends StatelessWidget {
  final String? title;
  final Widget? child;
  final Function()? onTap;
  const MoreBody({
    Key? key,
    this.title,
    this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title!,
                    style: AppTheme.headingColorBlue,
                  ),
                ),
                child!,
              ],
            ),
          ),
          Divider(
            color: customColor.withOpacity(.7),
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
