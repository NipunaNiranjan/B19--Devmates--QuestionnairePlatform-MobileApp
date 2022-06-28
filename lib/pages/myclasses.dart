import 'dart:convert';

import 'package:FLUTTER_MOBILE_APPLICATION/constant/constant.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/data/class_model.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/data/questionnaires_model.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/data/user_provider.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/pages/Dashboard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'myquestionnaire.dart';

class MyClassPage extends StatefulWidget {
  String id;
  String token;
  MyClassPage({required this.id, required this.token});

  @override
  _MyClassPagestate createState() => _MyClassPagestate();
}

class _MyClassPagestate extends State<MyClassPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<cBody>> getClasses() async {
    print(widget.id);
    final userProvider = UserProvider();
    List<cBody> class_list = [];
    try {
      var res = await userProvider.getClasses(widget.id, widget.token);
      final en_data = jsonEncode(res.data);
      final classes = Classes.fromJson(jsonDecode(en_data));
      print(classes.body[0].className);
      class_list = classes.body;
      return class_list;
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
          "My Classes",
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
        future: getClasses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            List _items = snapshot.data as List;
            return ListView.builder(
                shrinkWrap: false,
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return new InkWell(
                    child: Container(
                      height: 150.0,
                      margin: new EdgeInsets.all(10.0),
                      decoration: new BoxDecoration(
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(10.0)),
                          gradient: new LinearGradient(
                              colors: [Colors.purpleAccent, Colors.deepPurple],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              tileMode: TileMode.clamp)),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Padding(
                            padding:
                                new EdgeInsets.only(left: 10.0, right: 10.0),
                          ),
                          new Expanded(
                              child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                _items[index].className,
                                style: new TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold),
                              ),
                              new SizedBox(
                                height: 30.0,
                              ),
                              new Row(
                                children: <Widget>[
                                  new Column(
                                    children: <Widget>[
                                      new Text(
                                          'Enrolled Students :' +
                                              ' ' +
                                              _items[index]
                                                  .noOfStudents
                                                  .toString(),
                                          style: new TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          )),
                          new Padding(
                              padding:
                                  new EdgeInsets.only(left: 10.0, right: 10.0),
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text(
                                    _items[index].classId.toString(),
                                    style: new TextStyle(
                                        fontSize: 30.0, color: Colors.white70),
                                  ),
                                  new Text(
                                    'ClassID',
                                    style: new TextStyle(
                                        fontSize: 20.0, color: Colors.white70),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    onTap: () {
                      print('selected id is ${_items[index].classId}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyQuestionnairePage(
                                  classId: _items[index].classId.toString(),
                                  token: widget.token,
                                  std_id: widget.id,
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
