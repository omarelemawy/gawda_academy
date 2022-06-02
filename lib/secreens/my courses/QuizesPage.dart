import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/constants/themes.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/quizes.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/userData.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/wrapper/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuizesPage extends StatefulWidget {
  final List<Quizes>? quizes;
  static List<UserAnswers> userAnswersList = [];

  const QuizesPage({Key? key, this.quizes}) : super(key: key);
  @override
  _QuizesPageState createState() => _QuizesPageState();
}

class _QuizesPageState extends State<QuizesPage> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'Quizes')!),
      ),
      body: (loading)
          ? Center(child: SpinKitChasingDots(
        color: customColor,
        size: 40,
      ),)
          : FutureBuilder(
              future: QuizesApi.fetchMyCQuiszes(),
              builder: (context,AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return (snapshot.data.isEmpty)
                      ? userQuestions()
                      : userAnswers(snapshot);
                } else {
                  return Center(child: SpinKitChasingDots(
                    color: customColor,
                    size: 20,
                  ),);
                }
              },
            ),
    );
  }

  userAnswers(AsyncSnapshot quizes) {
    return ListView.builder(
      shrinkWrap: true,
      primary: true,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      itemCount: 1,
      itemBuilder: (context, index) {
        return ListView(
          shrinkWrap: true,
          primary: false,
          children: [
            Center(
              child: Text(
                quizes.data[index].quizes.name,
                style: AppTheme.headingColorBlue.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Center(
              child: Text(
                quizes.data[index].quizes.questions.length.toString() +
                    ' '
                        'question',
                style: AppTheme.subHeading.copyWith(
                  color: customColorGold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  getTranslated(context, 'yourmark')! + ': ',
                  style: AppTheme.subHeadingColorBlue.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  quizes.data[index].quizes.userMark.toString() +
                      ' / ' +
                      quizes.data[index].quizes.totlaMark.toString(),
                  style: AppTheme.subHeading.copyWith(
                    fontSize: 15,
                    color: customColorGold,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: quizes.data[index].quizes.questions.length,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              itemBuilder: (context, qindex) {
                return ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${qindex + 1} - ",
                          style: AppTheme.headingColorBlue.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          quizes.data[index].quizes.questions[qindex].text,
                          style: AppTheme.headingColorBlue.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: quizes
                          .data[index].quizes.questions[qindex].answers.length,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      itemBuilder: (context, ansindex) {
                        return (quizes.data[index].quizes.questions[qindex]
                                    .answers[ansindex].correct !=
                                '1')
                            ? Container()
                            : Row(
                                children: [
                                  Text(
                                    quizes.data[index].quizes.questions[qindex]
                                        .answers[ansindex].text,
                                    style: AppTheme.subHeading,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "( ${getTranslated(context, 'true')} )",
                                    style: AppTheme.heading
                                        .copyWith(color: customColor),
                                  )
                                ],
                              );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }

  userQuestions() {
    return ListView.builder(
      shrinkWrap: true,
      primary: true,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      itemCount: 1,
      itemBuilder: (context, index) {
        return ListView(
          shrinkWrap: true,
          primary: false,
          children: [
            Center(
              child: Text(
                widget.quizes![index].name!,
                style: AppTheme.headingColorBlue.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Center(
              child: Text(
                widget.quizes![index].questions.length.toString() +
                    ' '
                        'question',
                style: AppTheme.subHeading.copyWith(
                  color: customColorGold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: widget.quizes![index].questions.length,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              itemBuilder: (context, qindex) {
                return ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "${qindex + 1} - ",
                            style: AppTheme.headingColorBlue.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.quizes![index].questions[qindex].text!,
                            style: AppTheme.headingColorBlue.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          flex: 10,
                        ),
                      ],
                    ),
                    CustomRadioBattn(
                      anwsers: widget.quizes![index].questions[qindex].answers,
                      qustionId: widget.quizes![index].questions[qindex].id,
                      qusIndex: qindex,
                    ),
                  ],
                );
              },
            ),
            CustomButton(
              onPress: () {
                setState(() {
                  loading = !loading;
                });
                sentAnswers();
              },
              text: getTranslated(context, 'save'),
            ),
          ],
        );
      },
    );
  }

  sentAnswers() async {
    List answersList = [];
    for (var ans in QuizesPage.userAnswersList) {
      var answers = {
        "question_id": ans.qusId,
        "answer_id": ans.ansId,
      };
      answersList.add(answers);
    }
    var body = {
      'quiz_id': widget.quizes![0].id,
      'answers': answersList,
    };
    var encodeees = json.encode(body);
    print(encodeees);
    print(body);
    try {
      var response = await http.post(
        Utils.QuizAnssers_URL,
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': UserApp.userToken!,
          'lang': apiLang(),
        },
      );

      print(response.body);
      if (response.body == "done") {
        setState(() {
          loading = !loading;
        });
        showMyDialog(
          isTrue: true,
          context: context,
          message: response.body.toString(),
        );
      } else {
        var jsonData = json.decode(response.body);
        setState(() {
          loading = !loading;
        });
        showMyDialog(
          isTrue: false,
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

class CustomRadioBattn extends StatefulWidget {
  final int? qustionId;
  final int? qusIndex;
  final List<Answers>? anwsers;

  const CustomRadioBattn({Key? key, this.qustionId, this.qusIndex, this.anwsers})
      : super(key: key);
  @override
  _CustomRadioBattnState createState() => _CustomRadioBattnState();
}

class _CustomRadioBattnState extends State<CustomRadioBattn> {
  int? id;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      itemCount: widget.anwsers!.length,
      itemBuilder: (context, index) {
        return RadioListTile<int>(
          title: Text(
            widget.anwsers![index].text!,
            style: AppTheme.headingColorBlue,
          ),
          activeColor: customColorGold,
          groupValue: id,
          onChanged: (int? val) {
            setState(() {
              id = val;
              if (QuizesPage.userAnswersList.isEmpty) {
                UserAnswers userAnswers = UserAnswers(
                  qusId: widget.qustionId,
                  index: widget.qusIndex,
                  ansId: widget.anwsers![index].id,
                );
                QuizesPage.userAnswersList.add(userAnswers);
              } else {
                UserAnswers userAnswers = UserAnswers(
                  qusId: widget.qustionId,
                  index: widget.qusIndex,
                  ansId: widget.anwsers![index].id,
                );
                for (var ans in QuizesPage.userAnswersList) {
                  if (ans.index == userAnswers.index) {
                    QuizesPage.userAnswersList.remove(ans);
                    QuizesPage.userAnswersList.add(userAnswers);

                    return null;
                  }
                }
                QuizesPage.userAnswersList.add(userAnswers);
              }
            });
          },
          value: widget.anwsers![index].id!,
        );
      },
    );
  }
}

class UserAnswers {
  final int? qusId;
  final int? index;
  final int? ansId;
  UserAnswers({this.qusId, this.ansId, this.index});
}
