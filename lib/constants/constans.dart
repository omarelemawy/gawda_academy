import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/userData.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/authenticate/logIn/login.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/authenticate/register/phon_verification_screen.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/cart/cart.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/editprofile/editprofile.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/home/coursesSearch.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/instuctor/InstructorSearch.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/notifications/notifications.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/wrapper/wrapper.dart';
import 'package:elgawda_by_shay_b_haleb_new/services/UserData.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:html/parser.dart';
import 'package:simple_star_rating/simple_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';
import '../secreens/authenticate/first_sign_screen.dart';
import '../sharedPreferences.dart';

// import 'package:flutter_share/flutter_share.dart';

const customColor = Color(0xfff21496C);
const customColorGold = Color(0xfff8e0048);
const sliderTextColor = Color(0xfff21496C);
const sliderTextColorcontaint = Color(0xfff21496C);
const customColorIcon = Color(0xfff7D7D7D);
const customColorDivider = Color(0xfffe1e1e1);
const customColorGray = Color(0xfff7d7d7d);
const customColorbottomBar = Color(0xfffDBD8D2);
////////////////////////////////////////
Future<Null> customOnRefresh(
    {Function? onRefresh, FutureOr<dynamic> Function()? affterRefresh}) async {
  onRefresh!();

  await Future.delayed(
    Duration(seconds: 2),
    affterRefresh,
  );
  return null;
}

////////////////////////////////////////////////////////////

class LogoContainar extends StatelessWidget {
  const LogoContainar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/images/logo.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}

// cutomHttpWidget({String data}) {
//   return Html(
//     data: data,
//     style: {
//       "tr": Style(
//         border: Border(bottom: BorderSide(color: Colors.grey)),
//       ),
//       "th": Style(
//         padding: EdgeInsets.all(6),
//         backgroundColor: Colors.grey,
//       ),
//       "td": Style(
//         padding: EdgeInsets.all(6),
//       ),
//       "var": Style(fontFamily: 'serif'),
//     },
//     customRender: {
//       "flutter": (RenderContext context, Widget child, attributes, _) {
//         return FlutterLogo(
//           style: (attributes['horizontal'] != null)
//               ? FlutterLogoStyle.horizontal
//               : FlutterLogoStyle.markOnly,
//           textColor: context.style.color,
//           size: context.style.fontSize.size * 5,
//         );
//       },
//     },
//     onLinkTap: (url) {
//       print("Opening $url...");
//     },
//     onImageTap: (src) {
//       launchInBrowser(src);
//     },
//     onImageError: (exception, stackTrace) {
//       print(exception);
//     },
//   );
// }

String gitnewPrice({String? descaound, String? price}) {
  double oldPrice;
  oldPrice = double.parse(price!) - double.parse(descaound!);
  return oldPrice.toString();
}

String apiLang() {
  switch (UserApp.appLang) {
    case 'ar_EG':
      return 'ar';
      break;
    default:
      return 'en';
  }
}

/////////////////////////////////////
customCachedNetworkImage({String? url, BuildContext? context, BoxFit? boxFit}) {
  try {
    if (url == null || url == '') {
      return Container();
    } else {
      return Container(
        width: MediaQuery.of(context!).size.width,
        child: (Uri.parse(url).isAbsolute)
            ? CachedNetworkImage(
                imageUrl: url,
                fit: (boxFit) ?? BoxFit.contain,
                placeholder: (context, url) => Center(
                  child: SpinKitChasingDots(
                    color: customColor,
                    size: 20,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )
            : Icon(
                Icons.image,
                color: customColor,
              ),
      );
    }
  } catch (e) {
    print(e.toString());
  }
}

/////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
Future<void> showMyDialog({
  required BuildContext context,
  String? message,
  Function()? onTap,
  String? buttonText,
  required bool? isTrue,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: onTap ??
                        () {
                          Navigator.of(context).pop();
                        },
                  ),
                ),
                isTrue == true
                    ? Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('lib/images/profiletrue.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(),
                ListBody(
                  children: <Widget>[
                    // (isTrue == true)
                    //     ? Center(
                    //         child: Text(
                    //           getTranslated(context, 'AdministrativeMessage'),
                    //           style: AppTheme.heading.copyWith(
                    //             color: customColor,
                    //           ),
                    //         ),
                    //       )
                    //     : Container(),
                    Center(
                      child: Text(
                        message!,
                        style: AppTheme.headingColorBlue
                            .copyWith(color: customColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

//////////////////////////////////////////////////////////
PreferredSizeWidget customAppBar({String? title}) => AppBar(
      centerTitle: true,
      toolbarHeight: 70,
      backgroundColor: customColor,
      title: Text(
        title!,
        style: AppTheme.heading.copyWith(
          color: Colors.white,
        ),
      ),
    );

//////////////////////////////////////////////////////
class MyCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();

    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 2 - 150, size.height / 2,
        size.width / 2, size.height / 2 + 30);

    path.quadraticBezierTo(
        size.width, size.height - 60, size.width + 80, size.height / 2 - 150);

    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/////////////////////////////////////////////////////////////////////////////////
class CustomButton extends StatelessWidget {
  final String? text;
  final Function() onPress;

  CustomButton({required this.onPress, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(10),
        color: customColor,
        child: MaterialButton(
          onPressed: onPress,
          minWidth: 150,
          height: 48,
          child: Text(
            text!,
            style: AppTheme.heading.copyWith(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
/////////////////////////////////////////////////////////////////////////////////

class CustomButtonWithchild extends StatelessWidget {
  final Widget child;
  final Color color;
  final Function() onPress;

  CustomButtonWithchild(
      {required this.onPress, required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(30),
        color: color,
        child: MaterialButton(
          onPressed: onPress,
          minWidth: double.infinity,
          height: 48,
          child: child,
        ),
      ),
    );
  }
}
/////////////////////////////////////////////////////////////////////////////////

void showSettingsPanel({required BuildContext context, required Widget child}) {
  showModalBottomSheet(
    isScrollControlled: false,
    context: context,
    enableDrag: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    builder: (context) {
      return child;
    },
  );
}

/////////////////////////////////////////////////////////////////////////////////
newPrice({required double price, required double dis}) {
  return price - dis;
}

/////////////////////////////////////////////////////////////////////////////////
homeAppBar({required BuildContext context,  Widget? title}) {
  return AppBar(
    toolbarHeight: 80,
    title: title,
    leading: InkWell(
      onTap: () {
        flitter(
          context: context,
          child: EditProfile(),
        );
      },
      child: StreamBuilder<Users>(
        stream: DatabaseServices(
                context: context, userToken: UserApp.userToken.toString())
            .userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Users? users = snapshot.data;
            return InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => EditProfile()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Hero(
                  tag: 'UserImage',
                  child: Container(
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: customColor,
                        image: users!.image != '' && users.image != null
                            ? DecorationImage(
                                image: NetworkImage(users.image!),
                              )
                            : DecorationImage(
                                image: AssetImage(
                                'lib/images/man.png',
                              ))),
                  ),
                ),
              ),
            );
          } else {
            return InkWell(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => FirstSignScreen())),
              child: Container(
                child: Center(
                  child: Container(
                    width: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'lib/images/man.png',
                            ),
                            fit: BoxFit.contain),
                        color: customColor,
                        shape: BoxShape.circle),
                  ),
                ),
              ),
            );
          }
        },
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {
            showSettingsPanel(
                context: context,
                child: Container(
                  height: 150,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          showSearch(
                            context: context,
                            delegate: InstructorSearch(),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: customColor,
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'lib/images/boss.png',
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                getTranslated(context, 'search_instructor')
                                    .toString(),
                                style: AppTheme.heading
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          showSearch(
                            context: context,
                            delegate: CoursesSearch(),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: customColorGold,
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'lib/images/ebook.png',
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                getTranslated(context, 'search_course')
                                    .toString(),
                                style: AppTheme.heading
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          },
          child: Icon(
            Icons.search,
            color: customColorDivider,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => Notificatios(),
              ),
            );
          },
          child: Icon(
            Icons.notifications,
            color: customColor,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => (UserApp.userToken != 'null') ? Cart() : FirstSignScreen(),
              ),
            );
          },
          child: Icon(
            FontAwesomeIcons.shoppingCart,
            color: customColor,
          ),
        ),
      ),
    ],
  );
}

/////////////////////////////////////////////////////////////////////////////////
customRaiseButtom({required String text, required Function() onTap}) {
  // ignore: deprecated_member_use
  return RaisedButton(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    color: customColor,
    onPressed: onTap,
    child: Text(
      text,
      style: AppTheme.subHeading.copyWith(
        color: Colors.white,
      ),
    ),
  );
}

Future<void> cardDialog(
    {required BuildContext context, required String message}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,

    // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'lib/images/cancel.png',
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
              Center(
                child: Image.asset(
                  'lib/images/profiletrue.jpg',
                  width: 150,
                  height: 150,
                ),
              ),
              Center(
                child: Text(
                  (message.isEmpty) ?
                      'تم اضافة الطلب لإستكمال  عمليه الشراء عليك  الذهاب الي عربة التسوق'
                  :message,
                  style: AppTheme.subHeading,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              getTranslated(context, 'home').toString(),
              style: AppTheme.heading.copyWith(
                color: customColor,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => Wrapper()),
                (route) => false,
              );
            },
          ),
          TextButton(
            child: Text(
              getTranslated(context, 'cart').toString(),
              style: AppTheme.heading.copyWith(
                color: customColor,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => Cart(),
                ),
                ModalRoute.withName('/'),
              );
            },
          ),
        ],
      );
    },
  );
}

////////////////////////////////////////////////////////////////////////
increaseCartTotlaPrice({double? price}) async {
  print('increaseCartTotlaPrice:$price');
  double totalParice;
  totalParice = Cart.totalPraices + price!.toDouble();

  MySharedPreferences.saveTotalPrice(totalParice);
  Cart.totalPraices = await MySharedPreferences.getTotalPrice();
}

decreaseCartTotlaPrice({required double price}) async {
  double totalParice;
  totalParice = Cart.totalPraices - price;
  MySharedPreferences.saveTotalPrice(totalParice);
  Cart.totalPraices = await MySharedPreferences.getTotalPrice();
}

class CustomCarouselSlider extends StatefulWidget {
  final bool reverse;
  final Function() onTap;
  final List<dynamic> listOfObject;

  const CustomCarouselSlider({
     Key? key,
    required this.listOfObject,
    required this.reverse,
    required this.onTap,
  }) : super(key: key);

  @override
  _CustomCarouselSliderState createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> offer = widget.listOfObject;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        child: Column(
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                autoPlayInterval: Duration(seconds: 2),
                autoPlay: true,
                reverse: widget.reverse,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
              ),
              items: offer
                  .map(
                    (items) => Container(
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: 300,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        items.imgUrl,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Container(
                                    height: 100,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(height: 40),
                                        Text(
                                          items.contant,
                                          style: TextStyle(
                                            color: Colors.deepOrangeAccent,
                                            fontSize: 25,
                                          ),
                                        ),
                                        Text(
                                          items.title,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////
class RatingStar extends StatelessWidget {
  final double rating;

  const RatingStar({
    Key? key,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleStarRating(
      rating: rating,
      size: 20,
      isReadOnly: true,
      filledIcon: Icon(Icons.star,color: Colors.yellow[700],),
      // color: Colors.yellow[700],
      //
      // halfFilledIconData: Icons.star_half,
      // borderColor: Colors.yellow[900],
      // defaultIconData: Icons.star_border,
      nonFilledIcon: Icon(Icons.star_border,color:  Colors.yellow[900],),
      starCount: 5,
      allowHalfRating: true,
      spacing: 2.0,
    );
  }
}

///////////////////////////////////////////////////////////
class DismissibleWidget<T> extends StatelessWidget {
  final T item;
  final Widget child;
  final DismissDirectionCallback onDismissed;

  const DismissibleWidget({
    required this.item,
    required this.child,
    required this.onDismissed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Dismissible(
        key: UniqueKey(),
        background: buildSwipeActionRight(),
        child: child,
        onDismissed: onDismissed,
      );

  Widget buildSwipeActionRight() => Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: Icon(Icons.delete_forever, color: Colors.white, size: 32),
      );
}

/////////////////////////////////////////////////////////////
InkWell customSocialMdiaBottom({Function()? onTap, IconData? icon, Color? color}) {
  return InkWell(
    onTap: onTap,
    child: Icon(
      icon,
      color: color,
      size: 35,
    ),
  );
}

//////////////////////////////////////////////////////////////////////
flitter({required BuildContext context, required Widget child}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => child,
    isDismissible: true,
    enableDrag: true,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
    ),
    // isScrollControlled: true,
  );
}

/////////////////////////////////////////////////////////////
Future<void> launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}

// ------------------------------------------------------------------------
/////////////////////////////////////////////////////////////
Future<void> share({String? url, required String title}) async {
  await FlutterShare.share(
    title: title,
    linkUrl: url,
  );
}

// ------------------------------------------------------------------------
