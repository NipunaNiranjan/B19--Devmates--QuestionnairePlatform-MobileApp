import 'package:FLUTTER_MOBILE_APPLICATION/data/mcq_submission_model.dart';
import 'package:flutter/material.dart';

class AnswersWidget extends StatefulWidget {
  final List items;
  final int index;
  final McqSubmission mcqSubmission;
  const AnswersWidget(
      {Key? key,
      required this.items,
      required this.index,
      required this.mcqSubmission})
      : super(key: key);

  @override
  State<AnswersWidget> createState() => _AnswersWidgetState();
}

class _AnswersWidgetState extends State<AnswersWidget> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '(${widget.index + 1}) ' + widget.items[widget.index].question,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selected = 1;
                        });
                        widget.mcqSubmission.mcqAnswers.add(McqAnswer(
                            questionId: widget.items[widget.index].id,
                            option: 1));
                      },
                      child: Row(children: [
                        Icon((Icons.circle),
                            color:
                                selected == 1 ? Colors.purple : Colors.white),
                        SizedBox(width: 5),
                        Text(
                          widget.items[widget.index].option1,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selected = 2;
                        });
                        widget.mcqSubmission.mcqAnswers.add(McqAnswer(
                            questionId: widget.items[widget.index].id,
                            option: 2));
                      },
                      child: Row(children: [
                        Icon((Icons.circle),
                            color:
                                selected == 2 ? Colors.purple : Colors.white),
                        SizedBox(width: 5),
                        Text(widget.items[widget.index].option2,
                            style: TextStyle(
                              fontSize: 16,
                            ))
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selected = 3;
                        });
                        widget.mcqSubmission.mcqAnswers.add(McqAnswer(
                            questionId: widget.items[widget.index].id,
                            option: 3));
                      },
                      child: Row(children: [
                        Icon((Icons.circle),
                            color:
                                selected == 3 ? Colors.purple : Colors.white),
                        SizedBox(width: 5),
                        Text(widget.items[widget.index].option3,
                            style: TextStyle(
                              fontSize: 16,
                            ))
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selected = 4;
                        });
                        widget.mcqSubmission.mcqAnswers.add(McqAnswer(
                            questionId: widget.items[widget.index].id,
                            option: 4));
                      },
                      child: Row(children: [
                        Icon((Icons.circle),
                            color:
                                selected == 4 ? Colors.purple : Colors.white),
                        SizedBox(width: 5),
                        Text(widget.items[widget.index].option4,
                            style: TextStyle(
                              fontSize: 16,
                            ))
                      ]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
