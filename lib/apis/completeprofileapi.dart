import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


Future<void> postData(String name,int age,String phone,String email,String image) async {
  final String apiUrl = "https://mettl-hack.onrender.com/api/user";
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'Name': name,
      'Age': age,
      'Phone': phone,
      'Email': email,
      'ResumeImage': image,
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