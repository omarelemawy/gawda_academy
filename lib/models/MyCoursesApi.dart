import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/localization/localization_constants.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/InstructorApi.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/quizes.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/userData.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/utils.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/splashscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../sharedPreferences.dart';

class MyCoursesApi {
  static Future<List<CouresesModels>> fetchMyCourses(
      BuildContext context) async {
    List<CouresesModels> listOfCoureses = [];
    List<Answers> listOfAnswers = [];
    List<Questions> listOfQuestions = [];
    List<Quizes> listOfQuizes = [];
    List<Sections> listOfSections = [];

    print(
        "user token -------------------------------------------- ${UserApp.userToken}");
    /*try {*/
    var response = await http.get(
      Utils.MyCourses_URL,
      headers: {
        'x-api-key': UserApp.userToken.toString(),
      },
    );
    var jsonData = json.decode(response.body);
    print('MyCourses:${response.body}');
    if (response.statusCode == 200) {
      for (var cours in jsonData['data']) {
        /* print("data: ${jsonData['data']}");*/
        listOfSections = [];
        for (var sec in cours['sections']) {
          /*print("sections: ${cours['sections']}");*/
          listOfQuizes = [];

          for (var qui in sec['quizes']) {
            /* print("quizes: ${sec['quizes']}");*/
            listOfQuestions = [];
            for (var ques in qui['questions']) {
              /*print("questions: ${qui['questions']}");*/
              listOfAnswers = [];
              for (var ans in ques['answers']) {
                Answers answers = Answers(
                  id: ans['id'],
                  text: ans['text'],
                  correct: ans['correct'],
                );
                print("answers: ${answers.id}");
                listOfAnswers.add(answers);
              }
              Questions questions = Questions(
                answers: listOfAnswers,
                id: ques['id'],
                text: ques['text'],
                mark: ques['mark'],
              );
              print("questions: ${questions.id}");
              listOfQuestions.add(questions);
            }
            Quizes quizes = Quizes(
              id: qui['id'],
              name: qui['name'],
              totlaMark: qui['total_mark'],
              questions: listOfQuestions,
              userMark: qui['user_mark'] ?? 0,
            );
            print("quizes: ${quizes.id}");
            listOfQuizes.add(quizes);
          }
          Sections sections = Sections(
            id: sec['id'],
            name: sec['name'],
            quizes: listOfQuizes,
          );
          print("sections: ${sections.id}");
          listOfSections.add(sections);
        }
        CouresesModels coureses = CouresesModels(
          id: cours['id'],
          enrolled: cours['enrolled'],
          in_wish_list: cours['in_wish_list'],
          description: cours['description'],
          rate_count: cours['rate_count'],
          name: cours['name'],
          discount_message: cours['discount_message'],
          website_link: cours['website_link'],
          instructorName: cours['instructor']['name'],
          total_files: cours['featured_data']['total_files'],
          total_time: cours['featured_data']['total_time'],
          total_quizes: cours['featured_data']['total_quizes'],
          image_path: cours['image_path'],
          vimeo_code: cours['vimeo_code'],
          promo_video: cours['promo_video'],
          badges: cours['badges'],
          sectionsList: listOfSections,
          rate: cours['rate'],
          price: cours['price'],
          sections: cours['sections'],
          discount: cours['discount'],
          paymentStat: cours['payment_stat'] ?? "",
        );
        print("coureses: ${coureses.id}");
        listOfCoureses.add(coureses);
      }
    } else if (response.statusCode == 401) {
      print(jsonData);
      showMyDialog(
        context: context,
        isTrue: false,
        message: getTranslated(context, 'catchError').toString() +
            "\n" +
            getTranslated(context, 'Or').toString() +
            "\n" +
            jsonData['message'].toString() +
            "\n" +
            getTranslated(context, 'UserTokenField').toString(),
        onTap: () {
          MySharedPreferences.saveUserUserToken(null);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => SplashScreen(),
            ),
          );
        },
        buttonText: getTranslated(context, 'sign_in').toString(),
      );
    }
    /*} catch (e) {
      print('home MyCourses errrrrrrrrrrrrrrrrror : ${e.toString()}');

      print(e);
    }*/
    return listOfCoureses;
  }

  static Future<List<CouresesModels>> fetchMyWishList() async {
    List<CouresesModels>? listOfCoureses = [];
    List<Answers>? listOfAnswers = [];
    List<Questions>? listOfQuestions = [];
    List<Quizes>? listOfQuizes = [];
    List<Sections>? listOfSections = [];

    var response = await http.get(
      Utils.MyWishList_URL,
      headers: {
        'x-api-key': UserApp.userToken.toString(),
        'lang': apiLang(),
      },
    );
    var jsonData = json.decode(response.body);
    print('MyCourses:${response.statusCode}');
    if (response.statusCode == 200) {
      for (var cours in jsonData['data']) {
        listOfSections = [];
        for (var sec in cours['sections']) {
          listOfQuizes = [];

          for (var qui in sec['quizes']) {
            listOfQuestions = [];
            for (var ques in qui['questions']) {
              listOfAnswers = [];
              for (var ans in ques['answers']) {
                Answers answers = Answers(
                  id: ans['id'],
                  text: ans['text'],
                  correct: ans['correct'],
                );
                listOfAnswers.add(answers);
              }
              Questions questions = Questions(
                answers: listOfAnswers,
                id: ques['id'],
                text: ques['text'],
                mark: ques['mark'],
              );
              listOfQuestions.add(questions);
            }
            Quizes quizes = Quizes(
              id: qui['id'],
              name: qui['name'],
              totlaMark: qui['total_mark'],
              questions: listOfQuestions,
              userMark: qui['user_mark'] ?? 0,
            );
            listOfQuizes.add(quizes);
          }
          Sections sections = Sections(
            id: sec['id'],
            name: sec['name'],
            quizes: listOfQuizes,
          );
          listOfSections.add(sections);
        }
        CouresesModels coureses = CouresesModels(
          id: cours['id'],
          enrolled: cours['enrolled'],
          in_wish_list: cours['in_wish_list'],
          description: cours['description'],
          rate_count: cours['rate_count'],
          name: cours['name'],
          discount_message: cours['discount_message'] ?? "",
          website_link: cours['website_link'],
          instructorName: cours['instructor']['name'],
          total_files: cours['featured_data']['total_files'],
          total_time: cours['featured_data']['total_time'],
          total_quizes: cours['featured_data']['total_quizes'],
          image_path: cours['image_path'],
          vimeo_code: cours['vimeo_code'],
          promo_video: cours['promo_video'],
          badges: cours['badges'],
          sectionsList: listOfSections,
          rate: cours['rate'],
          price: cours['price'],
          sections: cours['sections'],
          discount: cours['discount'],
          paymentStat: cours['payment_stat'] ?? "",
        );
        listOfCoureses.add(coureses);
      }
    }
    return listOfCoureses;
  }
}
