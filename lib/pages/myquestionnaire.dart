import 'dart:convert';

import 'package:FLUTTER_MOBILE_APPLICATION/constant/constant.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/data/class_model.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/data/questionnaires_model.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/data/user_provider.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/pages/myquestions.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/pages/Dashboard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyQuestionnairePage extends StatefulWidget {
  String std_id;
  String classId;
  String token;
  MyQuestionnairePage(
      {required this.classId, required this.token, required this.std_id});

  @override
  _MyQuestionnairePagestate createState() => _MyQuestionnairePagestate();
}

class _MyQuestionnairePagestate extends State<MyQuestionnairePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<qBody>> getQuestionnaires() async {
    print(widget.classId);
    final userProvider = UserProvider();
    List<qBody> class_list = [];
    try {
      var res =
          await userProvider.getQuestionnaires(widget.classId, widget.token);
      final en_data = jsonEncode(res.data);
      final questionnaires = Questionnaires.fromJson(jsonDecode(en_data));
      //print(questionnaires.body[0].message);
      final questionnaire_list = questionnaires.body;
      return questionnaire_list;
    } catch (e) {
      print(e);
    }
    return class_list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Questionnaires",
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
      body: FutureBuilder(
        future: getQuestionnaires(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            List _items = snapshot.data as List;
            return ListView.builder(
                shrinkWrap: true,
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_items[index].name),
                    subtitle: Text(_items[index].description),
                    trailing: Text(_items[index].type),
                    onTap: () {
                      //print('selected id is ${_items[index].classId}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyQuestionsPage(
                                  id: _items[index].id.toString(),
                                  token: widget.token,
                                  type: _items[index].type.toString(),
                                  std_id: widget.std_id,
                                  class_id: widget.classId,
                                )),
                      );
                    },
                  );
                });
          } else if (snapshot.hasError) {
            if (snapshot.error.runtimeType == DioError) {
              DioError _error = snapshot.error as DioError;
              return Text(_error.toString());
            }
          }
          return Text('Something went wrong!');
        },
      ),
    );
  }
}
