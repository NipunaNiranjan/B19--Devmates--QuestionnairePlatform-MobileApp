import 'dart:convert';

import 'package:FLUTTER_MOBILE_APPLICATION/constant/constant.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/data/SAQuestions_model.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/data/class_model.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/data/mcq_submission_model.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/data/questionnaires_model.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/data/sa_submission_model.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/data/user_provider.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/pages/Dashboard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/data/mcqQuestions_model.dart';
import 'myquestionnaire.dart';
import '../pages/widgets/answersWidget.dart';

class MyQuestionsPage extends StatefulWidget {
  String std_id;
  String id;
  String token;
  String type;
  String class_id;
  late McqSubmission mcqSubmission;
  late SaSubmission saSubmission;
  MyQuestionsPage(
      {required this.id,
      required this.token,
      required this.type,
      required this.std_id,
      required this.class_id});

  @override
  _MyQuestionsPagestate createState() => _MyQuestionsPagestate();
}

class _MyQuestionsPagestate extends State<MyQuestionsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List> getQuestions() async {
    print(widget.id);
    print(widget.type);
    final userProvider = UserProvider();
    List questions_list = [];
    try {
      if (widget.type == 'SA') {
        widget.saSubmission = SaSubmission(
            studentId: int.parse(widget.std_id),
            questionnaireId: int.parse(widget.id),
            type: 'SA',
            shortAnswers: []);

        var res = await userProvider.getSAQuestions(widget.id, widget.token);
        final en_data = jsonEncode(res.data);
        final saquestions = SAQuestions.fromJson(jsonDecode(en_data));
        print(saquestions.body[0].name);
        questions_list = saquestions.body;
        return questions_list;
      } else if (widget.type == 'MCQ') {
        widget.mcqSubmission = McqSubmission(
            studentId: int.parse(widget.std_id),
            questionnaireId: int.parse(widget.id),
            type: 'MCQ',
            mcqAnswers: []);
        var res = await userProvider.getMCQQuestions(widget.id, widget.token);
        print(res.data);
        final en_data = jsonEncode(res.data);
        final mcqquestions = mcqQuestions.fromJson(jsonDecode(en_data));
        print(mcqquestions.body[0].question);
        questions_list = mcqquestions.body;
        return questions_list;
      }
    } catch (e) {
      print(e);
    }
    return questions_list;
  }

  @override
  Widget build(BuildContext context) {
    var no_of_sas = 0;
    List<TextEditingController> sa_answer_controler = [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Questions",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
              ])),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(
              top: 16,
              right: 16,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getQuestions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              List _items = snapshot.data as List;
              for (int i = 0; i < _items.length; i++) {
                sa_answer_controler.add(TextEditingController());
              }

              return Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        int selected = 0;
                        if (widget.type == 'SA') {
                          return Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '(${index + 1}) ' + _items[index].question,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  controller: sa_answer_controler[index],
                                  decoration: new InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.purple))),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    widget.saSubmission.shortAnswers.add(
                                        ShortAnswer(
                                            questionId: _items[index].id,
                                            answer: sa_answer_controler[index]
                                                .text));
                                  },
                                  child: Text(
                                    'Submit',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return AnswersWidget(
                          items: _items,
                          index: index,
                          mcqSubmission: widget.mcqSubmission,
                        );
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      final userProvider = UserProvider();
                      if (widget.type == 'SA') {
                        print(widget.saSubmission.shortAnswers[0].answer);
                        var body = saSubmissionToJson(widget.saSubmission);
                        try {
                          var en_data = jsonEncode(body);
                          var data = jsonDecode(en_data);
                          var res =
                              await userProvider.saveSA(body, widget.token);
                          print(res);
                        } catch (e) {
                          print(e);
                        }
                      } else {
                        var body = mcqSubmissionToJson(widget.mcqSubmission);
                        try {
                          var res =
                              await userProvider.saveMCQ(body, widget.token);
                          print(res);
                        } catch (e) {
                          print(e);
                        }
                      }
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyQuestionnairePage(
                                classId: widget.class_id,
                                token: widget.token,
                                std_id: widget.std_id)),
                      );
                    },
                    child: Text('Finish'),
                    color: Colors.purple.withOpacity(0.5),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              if (snapshot.error.runtimeType == DioError) {
                DioError _error = snapshot.error as DioError;
                return Text(_error.toString());
              }
            }
            return Text('Something went wrong!');
          },
        ),
      ),
    );
  }
}
