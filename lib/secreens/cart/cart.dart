import 'package:dio/dio.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/userData.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/cart/PaymentMethod.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/wrapper/wrapper.dart';
import 'package:elgawda_by_shay_b_haleb_new/services/dbhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../sharedPreferences.dart';

class Cart extends StatefulWidget {
  static double totalPraices = 0.0;
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  DbHehper? helper;
  getTotalPrice() async {
    Cart.totalPraices = await MySharedPreferences.getTotalPrice();
  }

  @override
  void initState() {
    helper = DbHehper();
    getTotalPrice();
    super.initState();
    print("Cart.totalPraices:${Cart.totalPraices}");
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => Wrapper()),
              (route) => false,
            );
          },
        ),
        title: Text(getTranslated(context, 'cart_title').toString()),
      ),
      body: (loading)
          ? Container(
              child: Center(
                child: SpinKitChasingDots(
                  color: customColor,
                  size: 40,
                ),
              ),
            )
          : FutureBuilder(
              future: helper!.allProduct(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else {
                  final data = snapshot.data as List;
                  return snapshot.data==null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                    color: customColor, shape: BoxShape.circle),
                                child: Image.asset(
                                  'lib/images/shopping-cart.png',
                                  fit: BoxFit.contain,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 20),
                              Center(
                                child: Text(
                                  getTranslated(context, 'cart_empty').toString(),
                                  style: AppTheme.heading,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView(
                          shrinkWrap: true,
                          primary: false,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          children: [
                            Text(
                              'Training Courses',
                              style: AppTheme.headingColorBlue
                                  .copyWith(fontSize: 16),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: customCachedNetworkImage(
                                            context: context,
                                            url: data[index]
                                                ['proImageUrl']),
                                      ),
                                      SizedBox(width: 5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                196,
                                            child: Text(
                                              data[index]['title'],
                                              style: AppTheme.headingColorBlue
                                                  .copyWith(fontSize: 10),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Pri: ',
                                                    style: AppTheme.heading
                                                        .copyWith(
                                                      color: customColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    data[index]['price']
                                                            .toString() +
                                                        getTranslated(
                                                            context, 'KD').toString(),
                                                    style: AppTheme.subHeading
                                                        .copyWith(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Center(
                                        child: InkWell(
                                          onTap: () async {
                                            setState(() {});
                                            await helper!.deleteProduct(
                                                data[index]['id']);
                                            setState(() {
                                              decreaseCartTotlaPrice(
                                                price: data[index]
                                                    ['price'],
                                              );
                                            });
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Divider(
                              color: customColor,
                              thickness: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  getTranslated(context, 'total').toString(),
                                  style: AppTheme.headingColorBlue
                                      .copyWith(fontSize: 16),
                                ),
                                SizedBox(width: 20),
                                Text(
                                  Cart.totalPraices.toStringAsFixed(2) + '\$',
                                  style: AppTheme.headingColorBlue.copyWith(
                                      fontSize: 16, color: customColorGold),
                                ),
                                SizedBox(width: 20),
                              ],
                            ),
                            Center(
                              child: Text(
                                getTranslated(context, 'Choose_Payment').toString(),
                                style: AppTheme.heading,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                customRaiseButtom(
                                  text: getTranslated(context, 'Cash').toString(),
                                  onTap: () {
                                    setState(() {
                                      loading = !loading;
                                    });
                                    checkOut(item: snapshot);
                                  },
                                ),
                                SizedBox(width: 10),
                                customRaiseButtom(
                                  text: getTranslated(context, 'Credit').toString(),
                                  onTap: () {
                                    setState(() {
                                      loading = !loading;
                                    });
                                    creditOut(item: snapshot);
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                }
              },
            ),
    );
  }

  checkOut({var item}) async {
    List courses = [];
    for (var items in item.data) {
      courses.add(items['CoursesId']);
    }
    print("courses ---------------------------------------------- : $courses");
    /*try {*/
      var body = {
        'courses': courses,
        'payment_method': 'cash',
      };
     /* var formData = FormData.fromMap({
      'courses': courses,
      'payment_method': 'cash',
      });*/
      Dio dio=Dio();
     /* print(formData);*/
      Response<String> response=await dio.post(Utils.Checkout_URL.toString(),
          options: Options(headers: {
      'x-api-key': UserApp.userToken.toString(),
      'lang': apiLang(),
      },),data: body);
     /* var response = await http.post(
        Utils.Checkout_URL,
        body:json.encode(body),
        headers: {
          'x-api-key': UserApp.userToken.toString(),
          'lang': apiLang(),
        },
      );*/
    print(response.data);
      var jsonData = json.decode(response.data!);
      print(jsonData);

      if (jsonData['success'] == true) {
        await helper!.deleteAllProduct();
        decreaseCartTotlaPrice(
          price: Cart.totalPraices,
        );
        /*    Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (_) => SucessView(),));*/
        setState(() {
          loading = !loading;
        });
        showMyDialog(
          isTrue: true,
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => Wrapper(),
              ),
            );
          },
          context: context,
          message: getTranslated(context, 'cash_success'),
        );
      } else {
        setState(() {
          loading = !loading;
        });
        showMyDialog(
          isTrue: false,
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => Wrapper(),
              ),
            );
          },
          context: context,
          message: jsonData['message'].toString(),
        );
      }
    /*} catch (e) {
      showMyDialog(
        isTrue: false,
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => Wrapper(),
            ),
          );
        },
        context: context,
        message: getTranslated(context, 'catchError'),
      );
      setState(() {
        loading = !loading;
      });

      print(e);
    }*/
  }

  creditOut({var item}) async {
    List courses = [];
    for (var items in item.data) {
      courses.add(items['CoursesId']);
    }

    try {
      var body = {
        'courses': courses,
        'payment_method': 'credit',
      };

      var response = await http.post(
        Utils.Checkout_URL,
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': UserApp.userToken.toString(),
          'lang': apiLang(),
        },
      );

      var jsonData = json.decode(response.body);
      print(jsonData);

      if (jsonData['success'] == true) {
        setState(() {
          loading = !loading;
        });
        await helper!.deleteAllProduct();
        decreaseCartTotlaPrice(
          price: Cart.totalPraices,
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => PaymentMethod(
              url: jsonData['data']['payment_url'],
            ),
          ),
        );
      } else {
        setState(() {
          loading = !loading;
        });
        showMyDialog(
          isTrue: false,
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => Wrapper(),
              ),
            );
          },
          context: context,
          message: jsonData['message'].toString(),
        );
      }
    } catch (e) {
      setState(() {
        loading = !loading;
      });
      showMyDialog(
        isTrue: false,
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => Wrapper(),
            ),
          );
        },
        context: context,
        message: getTranslated(context, 'catchError'),
      );

      print(e);
    }
  }
}
