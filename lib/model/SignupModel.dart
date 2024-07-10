import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupFormet extends StatefulWidget {
  @override
  State<SignupFormet> createState() => _SignupFormetState();
}

class _SignupFormetState extends State<SignupFormet> {
  final _signupFormKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _nickName = '';

  Future<void> _signUp() async {
    if (!_signupFormKey.currentState!.validate()) return;

    _signupFormKey.currentState!.save();

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/auth'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': _username,
          'password': _password,
          'nickName': _nickName,
        }),
      );

      if (response.statusCode == 200) {
        _showDialog('성공', '회원가입 성공!', () {
          Navigator.pushNamed(context, '/login');
        });
      } else {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        _showDialog('오류', responseData['message'] ?? '회원가입 실패');
      }
    } catch (error) {
      print(error);
      _showDialog('Error', error.toString());
    }
  }

  void _showDialog(String title, String message, [VoidCallback? onConfirm]) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('확인'),
            onPressed: () {
              Navigator.of(context).pop();
              if (onConfirm != null) onConfirm();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _signupFormKey,
        child: Column(
          children: [
            SizedBox(height: 5.0),
            CustomTextFormField('Id'),
            SizedBox(height: 15.0),
            CustomTextFormField('Password'),
            SizedBox(height: 15.0),
            CustomTextFormField('Nickname'),
            SizedBox(height: 15),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  submitButton(context),
                  SizedBox(width: 20),
                  returnButton(context)
                ]),
          ],
        ));
  }

  // input
  Widget CustomTextFormField(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        SizedBox(height: 5.0),
        TextFormField(
            validator: (val) => val!.isEmpty ? "Fill the value" : null,
            obscureText: text == "Password" ? true : false,
            decoration: InputDecoration(
              hintText: "Enter $text",
            ),
            onSaved: (value) {
              if (text == 'Id') {
                _username = value!;
              } else if (text == 'Password') {
                _password = value!;
              } else {
                _nickName = value!;
              }
            })
      ],
    );
  }

  Widget submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _signUp,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: const Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
  Widget returnButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () => {Navigator.pushNamed(context, '/login')},
        child: Container(
          padding: const EdgeInsets.all(10),
          child:const Text('Return',
            style: TextStyle(fontSize:18),),
        )
    );
  }

}