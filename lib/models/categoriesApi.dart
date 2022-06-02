import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/InstructorApi.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/quizes.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriesModels {
  final int? id;
  final List<SubCategoriesModels>? subcategories;
  final String? name;
  final String? image;

  CategoriesModels({
    required this.id,
    required this.name,
    required this.image,
    required this.subcategories,
  });
}

class SubCategoriesModels {
  final int? id;
  final String? name;
  final String? image;

  SubCategoriesModels({
    required this.id,
    required this.name,
    required this.image,
  });
}

class CategoriesApi {
  static Future<String?> getVideoMp4Link({var id}) async {
    String? link;
    try {
      var response = await http.get(
        Uri.parse('https://player.vimeo.com/video/$id/config'),
        headers: {
          'lang': apiLang(),
        },
      );
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var url in jsonData['request']['files']['progressive']) {
          if (url['quality'] == "360p") {
            link = url['url'];
          } else if (url['quality'] == "240p") {
            link = url['url'];
          } else {
            link = url['url'];
          }
        }

        print(
            'vimeo video -------------------------------------------------------:$link');
      }
    } catch (e) {
      print(
          "vimeo video errrrrror ======================================= ${e.toString()}");
    }
    return link;
  }

  static Future<List<CategoriesModels>> fetchAllCategories() async {
    List<CategoriesModels> listOfCategoriesModels = [];
    List<SubCategoriesModels> listOfSubCategoriesModels = [];

    try {
      var response = await http.get(
        Utils.Categories_URL,
        headers: {
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
    } catch (e) {
      print('All Gater errror');

      print(e);
    }
    return listOfCategoriesModels;
  }

  static Future<List<CouresesModels>> fetchCategrsCoursesByid(int? id) async {
    List<CouresesModels> listOfCoureses = [];
    List<Answers> listOfAnswers = [];
    List<Questions> listOfQuestions = [];
    List<Quizes> listOfQuizes = [];
    List<Sections> listOfSections = [];

    // try {
    var response = await http.get(
      Uri.parse(Utils.Categories_URL.toString() + '/$id'),
      headers: {
        'lang': apiLang(),
      },
    );

    var jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      for (var cours in jsonData['data']['courses']) {
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
        print("coureses: ${coureses.id}");
        print("bbbbbb");
        listOfCoureses.add(coureses);
      }
    }
    print("bbbbbb");
    print(id);
    // } catch (e) {
    //   print('home CatCourses errror');
    //
    //   print(e);
    // }
    return listOfCoureses;
  }
}
