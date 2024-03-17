import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


Future<Map<String, dynamic>?> sendQuestionData(String jobdescription,String jobrequirements,String level,String emailid ) async {
  try {
    final Dio dio = Dio();
    final response = await dio.post(
      'https://mettl-hack.onrender.com/api/questions',
      options: Options(headers: {'Content-Type': 'application/json'}),
      data: jsonEncode({
        "job_description": jobdescription,
        "job_requirements":jobrequirements,
        "interview_level": level,
        "email": emailid,
      }),
    );
    print("1232525");
    print("Response: ${response.data}");

    if (response.statusCode == 200) {
      print("code successfull");
      return response.data;
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Exception: $e');
    return null;
  }
}