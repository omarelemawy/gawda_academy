import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/userData.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/editprofile/editprofile.dart';
import 'package:elgawda_by_shay_b_haleb_new/services/UserData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MoreUserData extends StatefulWidget {
  final UserDate? userDate;

  const MoreUserData({Key? key, this.userDate}) : super(key: key);

  @override
  _MoreUserDataState createState() => _MoreUserDataState();
}

class _MoreUserDataState extends State<MoreUserData> {
  bool _isError = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        flitter(
          context: context,
          child: EditProfile(),
        );
      },
      child: StreamBuilder<Users>(
        stream: DatabaseServices(context: context, userToken: UserApp.userToken!)
            .userData,
        builder: (context,AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Users users = snapshot.data;
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            (users.image != '' && users.image != null)?
            CircleAvatar(
                  maxRadius: 45,
                  backgroundColor: customColor,
                  backgroundImage: NetworkImage(users.image!),
                  onBackgroundImageError: (_, __) {
                    setState(() {
                      this._isError = true;
                    });
                  },
                  child: (this._isError) ? Icon(Icons.error) : Container(),
                ):
            CircleAvatar(
                  maxRadius: 45,
                  backgroundColor: customColor,
                  backgroundImage: AssetImage(
                    'lib/images/man.png',
                  ),
                  onBackgroundImageError: (_, __) {
                    setState(() {
                      this._isError = true;
                    });
                  },
                  child: (this._isError) ? Icon(Icons.error) : Container(),
                ),
                SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.57,
                      child: Text(
                        users.name!,
                        maxLines: 2,
                        style: AppTheme.headingColorBlue,
                      ),
                    ),
                    (users.email != 'null')
                        ? Text(
                            (users.email! == getTranslated(context, 'addEmail')!
                                ? ''
                                : users.email!),
                            style: AppTheme.subHeadingColorBlue,
                          )
                        : Container(),
                  ],
                ),
              ],
            );
          } else {
            return Container(
              child: Center(
                child: SpinKitChasingDots(
                  color: customColor,
                  size: 20,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
