import 'package:dio/dio.dart';
import 'package:FLUTTER_MOBILE_APPLICATION/constant/constant.dart';

class UserProvider {
  final dio = new Dio();
  Future<Response> registerUser(Map body) async {
    //try {
    final url = RESTAPI + "/api/v1/auth/signup";
    var res = await dio.post(url, data: body);
    print(res);
    return res;
  }

  Future<Response> loginUser(Map body) async {
    //try {
    final url = RESTAPI + "/api/v1/auth/signin";
    var res = await dio.post(url, data: body);
    print(res);
    return res;
  }

  Future<Response> getClasses(String id, String token) async {
    final url = RESTAPI + '/api/v1/class/student/' + id;
    print(token);
    var res = await dio.get(url,
        options: Options(headers: {"Authorization": "Bearer " + token}));
    print(res.data);
    return res;
  }

  Future<Response> getMCQQuestions(String id, String token) async {
    final url = RESTAPI + '/api/v1/mcq_questions/' + id;
    print(token);
    var res = await dio.get(url,
        options: Options(headers: {"Authorization": "Bearer " + token}));
    print(res.data);
    return res;
  }

  Future<Response> getSAQuestions(String id, String token) async {
    final url = RESTAPI + '/api/v1/questions/' + id;
    print(token);
    var res = await dio.get(url,
        options: Options(headers: {"Authorization": "Bearer " + token}));
    print(res.data);
    return res;
  }

  Future<Response> getQuestionnaires(String id, String token) async {
    final url = RESTAPI + '/api/v1/questionnaires/class/' + id;
    print(token);
    var res = await dio.get(url,
        options: Options(headers: {"Authorization": "Bearer " + token}));
    print(res.data);
    return res;
  }

  Future<Response> saveSA(String body, String token) async {
    final url = RESTAPI + '/api/v1/submissions/';
    print(token);
    var res = await dio.post(url,
        data: body,
        options: Options(headers: {"Authorization": "Bearer " + token}));
    print(res.data);
    return res;
  }

  Future<Response> saveMCQ(String body, String token) async {
    final url = RESTAPI + '/api/v1/submissions';
    print(token);
    var res = await dio.post(url,
        data: body,
        options: Options(headers: {"Authorization": "Bearer " + token}));
    print(res.data);
    return res;
  }
}
