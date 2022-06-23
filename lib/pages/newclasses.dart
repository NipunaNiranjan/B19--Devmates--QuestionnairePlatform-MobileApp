import 'dart:convert';

import 'package:FLUTTER_MOBILE_APPLICATION/constant/constant.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/data/class_model.dart';
//import 'package:FLUTTER_MOBILE_APPLICATION/data/questionnaires_model.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/data/user_provider.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/pages/category.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/pages/questionnaires.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClassPage extends StatefulWidget {
  String id;
  String token;
  ClassPage({required this.id, required this.token});

  @override
  _ClassPagestate createState() => _ClassPagestate();
}

class _ClassPagestate extends State<ClassPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<Body>> getClasses() async {
    print(widget.id);
    final userProvider = UserProvider();
    List<Body> class_list = [];
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
    getClasses();

    final classes = FutureBuilder(
        future: getClasses(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<InkWell> arr = [];
            for (int i = 0; i < snapshot.data.length; i++) {
              arr.add(
                InkWell(
                  onTap: () async {
                    final userProvider = UserProvider();
                    // var res = await userProvider.getQuestionnaires(
                    //     snapshot.data[i].classId, widget.token);
                    // var en_data = jsonEncode(res.data);
                    // Questionnaires qs =
                    //     questionnairesFromJson(jsonDecode(en_data));
                    // print(qs.body);
                  },
                  child: Container(
                    child: Card(
                      child: Column(
                        children: [
                          Text("Course name: " + snapshot.data[i].className)
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return Column(
              children: arr,
            );
          }
          return CircularProgressIndicator.adaptive();
        });
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
      body: Padding(
        padding: EdgeInsets.only(left: 20, top: 50, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            Text("Hey UserName,", style: kHeadingextStyle),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 80),
                Text("Classes", style: kTitleTextStyle),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: classes,
              // child: StaggeredGridView.countBuilder(
              //   padding: EdgeInsets.all(0),
              //   crossAxisCount: 2,
              //   itemCount: categories.length,
              //   crossAxisSpacing: 20,
              //   mainAxisSpacing: 20,
              //   itemBuilder: (context, index) {
              //     return GestureDetector(
              //         onTap: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => ClassPage(
              //                 id: '',
              //                 token: '',
              //               ),
              //             ),
              //           );
              //         },
              //         child: classes);
              //   },
              //   staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
