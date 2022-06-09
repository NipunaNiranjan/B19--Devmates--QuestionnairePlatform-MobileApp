import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
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
                      text: "Oct",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF263064),
                        fontSize: 22,
                      ),
                      children: [
                        TextSpan(
                          text: " 2009",
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
