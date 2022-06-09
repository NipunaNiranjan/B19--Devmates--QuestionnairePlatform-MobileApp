import 'package:flutter/material.dart';

class ClassPage extends StatefulWidget {
  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          alignment: Alignment.topCenter,
          color: Color(0xFFF0F0F0),
          height: MediaQuery.of(context).size.height,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.grey),
                SizedBox(
                  width: 15,
                ),
                RichText(
                  text: TextSpan(
                      text: "June",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF263064),
                        fontSize: 22,
                      ),
                      children: [
                        TextSpan(
                          text: " 2022",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      ]),
                ),
              ],
            )
          ]))
    ]);
  }
}
