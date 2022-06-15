import 'package:flutter/material.dart';

class ClassPage extends StatefulWidget {
  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  List<Mycard> mycard = [
    Mycard(Icons.school, 'Class A', true),
    Mycard(Icons.school, 'Class B', false),
    Mycard(Icons.school, 'Class C', false),
    Mycard(Icons.school, 'Class D', false),
    Mycard(Icons.school, 'Class E', false),
    Mycard(Icons.school, 'Class F', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f7f9),
      appBar: AppBar(
        title: Text('Your Classes'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Choose your Subject',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: mycard
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ClassPage()),
                          );
                        },
                        child: Card(
                          color: e.isActive ? Colors.deepPurple : null,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                e.icon,
                                size: 50,
                                color: e.isActive
                                    ? Colors.white
                                    : Colors.deepPurple,
                              ),
                              SizedBox(height: 10),
                              Text(
                                e.title,
                                style: TextStyle(
                                    fontSize: 30,
                                    color: e.isActive
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Mycard {
  final icon;
  final title;
  bool isActive = false;

  Mycard(this.icon, this.title, this.isActive);
}
