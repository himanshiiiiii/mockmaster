import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

Future<void> SubmitAnswer(String answer, String question,String interviewId,String emailId,int index, String level) async {
  final String apiUrl = "https://mettl-hack.onrender.com/api/submit";
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'interview_id': interviewId,
      'email': emailId,
      'question_index': index,
      'answer': answer,
      'difficulty_level': level
    }),
  );

  if (response.statusCode == 200) {
    print("Request successful");
    print(response.body);
  } else {
    print("Response body: ${response.body}");
    print("Request failed with status: ${response.statusCode}");
  }
}