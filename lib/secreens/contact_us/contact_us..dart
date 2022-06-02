import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/chatApi.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/userData.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  List<String> messageList = [];
  TextEditingController _messageController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getTranslated(context, 'contact_us').toString(),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            (loading)
                ? Center(child:  SpinKitChasingDots(
              color: customColor,
              size: 20,
            ),)
                : Expanded(
                    child: FutureBuilder(
                      future: ChatApi.fetchAllContactUSMessages(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data =snapshot.data as List<MessageModels>;
                          return (snapshot.data==null)
                              ? Container()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    print(
                                        'CouresChat Id:${data[index].sender}');
                                    return MessageTile(
                                      message: data[index].message,
                                      isSendByme:
                                          data[index].sender == 'user',
                                      date: data[index].created_at,
                                    );
                                  },
                                );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
            messageTextFiled(),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  Container serviesMessage({String? message}) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: customColorbottomBar,
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          message!,
          textDirection: TextDirection.ltr,
          style: AppTheme.subHeadingColorBlue,
        ),
      ),
    );
  }

  Container messageTextFiled() {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: customColorGray),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _messageController,
              maxLines: null,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: (loading)
                    ? getTranslated(context, 'Sending')
                    : getTranslated(context, 'Write_a_message'),
                hintStyle: AppTheme.subHeading.copyWith(
                  fontSize: 10,
                  color: customColorIcon,
                ),
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () {

              sentMessage(_messageController.text);
              setState(() {
                _messageController.text = '';
              });
            },
            child: Container(
              child: Icon(
                Icons.send,
                color: customColorIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  sentMessage(String message) async {
    setState(() {
      loading = true;
    });
    try {
      var response = await http.post(
        Uri.parse(Utils.Contactus_URL.toString() + '/send_message'),
        body: {
          'message': message,
        },
        headers: {
          'x-api-key': UserApp.userToken.toString(),
          'lang': apiLang(),
        },
      );
      print(response.statusCode);

      Map<String, dynamic> map = json.decode(response.body);
      print(map);
      if (map['success'] == false) {

        setState(() {
          loading = !loading;
        });
        showMyDialog(
            isTrue: false,
            context: context,
            message: map['message'].toString());
      } else {
        print('successppppppppp');
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        loading = !loading;
      });
      showMyDialog(
        isTrue: false,
        context: context,
        message: getTranslated(context, 'catchError'),
      );
      print(
          'Catchhhhhhhhhhhhhhhhhhhhhhh errororororrorrorooroeoreoroeroeorero');
      print(e.toString());
    }
  }
}

class MessageTile extends StatefulWidget {
  final String? message;
  final bool? isSendByme;
  final String? date;

  const MessageTile({Key? key, this.message, this.isSendByme, this.date})
      : super(key: key);
  @override
  _MessageTileState createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    print(widget.isSendByme);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      alignment:
          (widget.isSendByme==true) ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: (widget.isSendByme==true)
            ? EdgeInsets.only(left: 100)
            : EdgeInsets.only(right: 100),
        decoration: BoxDecoration(
            color: (widget.isSendByme==true) ? customColor : Color(0xffff1f1f1),
            borderRadius: (widget.isSendByme==true)
                ? BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.message!,
              style: AppTheme.heading.copyWith(
                color: (widget.isSendByme==true) ? Colors.white : customColor,
                fontSize: 11,
              ),
            ),
            Align(
              alignment: (UserApp.appLang == 'ar_EG')
                  ? (widget.isSendByme==true)
                      ? Alignment.bottomRight
                      : Alignment.bottomLeft
                  : (widget.isSendByme!)
                      ? Alignment.bottomLeft
                      : Alignment.bottomRight,
              child: Text(
                widget.date!,
                style: AppTheme.heading.copyWith(
                  color: (widget.isSendByme==true) ? Colors.white : customColor,
                  fontSize: 8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
