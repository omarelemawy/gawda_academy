import 'package:elgawda_by_shay_b_haleb_new/constants/constans.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/userData.dart';
import 'package:elgawda_by_shay_b_haleb_new/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Answers {
  final int? id;
  final String? text;
  final int? correct;

  Answers({required this.id, required this.text, required this.correct});
}

class Questions {
  final int? id;
  final String? text;
  final int? mark;

  final List<Answers> answers;

  Questions(
      {required this.id,
      required this.text,
      required this.answers,
      required this.mark});
}

class Quizes {
  final int? id;
  final String? name;
  final int? totlaMark;
  final int? userMark;

  final List<Questions> questions;

  Quizes(
      {required this.id,
      required this.name,
      required this.questions,
      required this.totlaMark,
      required this.userMark});
}

class Sections {
  final int? id;
  final String? name;

  final List<Quizes>? quizes;

  Sections({required this.id, required this.name, required this.quizes});
}

class Resources {
  final int? id;
  final String? name;
  final String? filePath;

  Resources({required this.id, required this.name, required this.filePath});
}

class UsersAnswes {
  final Quizes? quizes;

  UsersAnswes({required this.quizes});
}

class QuizesApi {
  static Future<List<UsersAnswes>>? fetchMyCQuiszes() async {
    List<Answers>? listOfAnswers = [];
    List<UsersAnswes>? listOfUsersAnswes = [];
    List<Questions>? listOfQuestions = [];

    try {
      var response = await http.get(
        Utils.QuizAnssers_URL,
        headers: {
          'x-api-key': UserApp.userToken.toString(),
          'lang': apiLang(),
        },
      );
      var jsonData = json.decode(response.body);
      print('MyCourses:${response.statusCode}');
      for (var quize in jsonData['data']) {
        listOfQuestions = [];
        for (var ques in quize['quiz']['questions']) {
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
            id: ques['id'],
            text: ques['text'],
            mark: ques['mark'],
            answers: listOfAnswers,
          );
          listOfQuestions.add(questions);
        }
        Quizes quizes = Quizes(
          questions: listOfQuestions,
          id: quize['quiz']['id'],
          name: quize['quiz']['name'],
          totlaMark: quize['quiz']['total_mark'],
          userMark: quize['user_mark'],
        );

        UsersAnswes userAnswers = UsersAnswes(
          quizes: quizes,
        );
        listOfUsersAnswes.add(userAnswers);
      }

      if (response.statusCode == 200) {}
    } catch (e) {
      print('home Qwizes Ansser errrrrrrrrrrrrrrrrror');

      print(e);
    }
    return listOfUsersAnswes;
  }
}
