import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/InstructorApi.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/categoriesApi.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/quizes.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/userData.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeDaTaApi {
  //HOME featured_courses

  static Future<List<CouresesModels>> fetchFeaturedCourses() async {
    List<CouresesModels>? listOfCoureses = [];
    List<Answers>? listOfAnswers = [];
    List<Questions>? listOfQuestions = [];
    List<Quizes>? listOfQuizes = [];
    List<Sections>? listOfSections = [];
    try {
      var response = await http.get(
        Utils.HOME_URL,
        headers: {
          'lang': apiLang(),
          'x-api-key': UserApp.userToken.toString(),
        },
      );
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var cours in jsonData['data']['featured_courses']) {
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
                userMark: qui['user_mark'],
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
            paymentStat: cours['payment_stat'],
          );
          listOfCoureses.add(coureses);
        }
      }
    } catch (e) {
      print('home slider errror');
      print(e);
    }
    return listOfCoureses;
  }

  //HOME SLIDER
  static Future<List<CouresesModels>> fetchHomeSlider() async {
    List<CouresesModels>? listOfCoureses = [];
    List<Answers>? listOfAnswers = [];
    List<Questions>? listOfQuestions = [];
    List<Quizes>? listOfQuizes = [];
    List<Sections>? listOfSections = [];
    try {
      var response = await http.get(
        Utils.HOME_URL,
        headers: {
          'lang': apiLang(),
          'x-api-key': UserApp.userToken.toString(),
        },
      );
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var cours in jsonData['data']['slider']) {
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
                userMark: qui['user_mark'],
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
            paymentStat: cours['payment_stat'],
          );
          listOfCoureses.add(coureses);
        }
      }
    } catch (e) {
      print('home slider errror');

      print(e);
    }
    return listOfCoureses;
  }

  static Future<List<CategoriesModels>> fetchHomeCategories() async {
    List<CategoriesModels>? listOfCategoriesModels = [];
    List<SubCategoriesModels>? listOfSubCategoriesModels = [];

    // try {
    var response = await http.get(
      Utils.Categories_URL,
      headers: {
        'x-api-key': UserApp.userToken.toString(),
        'lang': apiLang(),
      },
    );
    var jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      for (var cours in jsonData['data']) {
        listOfSubCategoriesModels = [];
        for (var sub in cours['subcategories']) {
          SubCategoriesModels categories = SubCategoriesModels(
            id: sub['id'],
            name: sub['name'],
            image: sub['image'],
          );
          listOfSubCategoriesModels.add(categories);
        }
        CategoriesModels categories = CategoriesModels(
          id: cours['id'],
          name: cours['name'],
          image: cours['image'],
          subcategories: listOfSubCategoriesModels,
        );
        listOfCategoriesModels.add(categories);
      }
    }
    // } catch (e) {
    //   print('home GAtro errror');

    //   print(e);
    // }
    return listOfCategoriesModels;
  }

  static Future<List<CouresesModels>> cursesSearch(String name) async {
    List<CouresesModels>? listOfCoureses = [];
    List<Answers>? listOfAnswers = [];
    List<Questions>? listOfQuestions = [];
    List<Quizes>? listOfQuizes = [];
    List<Sections>? listOfSections = [];

    var response = await http.get(
      Uri.parse(Utils.HOMESearch_URL.toString() + "?search=$name"),
      headers: {
        'x-api-key': UserApp.userToken.toString(),
        'lang': apiLang(),
      },
    );
    var jsonData = json.decode(response.body);
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
          paymentStat: cours['payment_stat'],
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
        );
        listOfCoureses.add(coureses);
      }
    }

    return listOfCoureses;
  }
}
