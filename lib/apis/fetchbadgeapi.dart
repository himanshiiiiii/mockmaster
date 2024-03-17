
import 'dart:convert';
import 'package:dio/dio.dart';


Future<Map<String, dynamic>?> fetchBadge(String emailId) async {
  try {
    final Dio dio = Dio();
    final response = await dio.post(
      'https://mettl-hack.onrender.com/api/badge',
      options: Options(headers: {'Content-Type': 'application/json'}),
      data: jsonEncode({"email": emailId}),
    );

    if (response.statusCode == 200) {
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