import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/model/LoginModel.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            SizedBox(height: 100.0),
            Center(child: Text("Stock News", style: TextStyle(fontSize: 30))),
            SizedBox(height: 20.0),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}

// 재사용 할 수 있는 input field

