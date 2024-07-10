import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formResponse = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String username = _idController.text;
    final String password = _passwordController.text;

    if (_formResponse.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse('http://localhost:8080/auth/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'username': username,
            'password': password,
          }),
        );
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          final String accessToken = responseData['accessToken'];
          final String refreshToken = responseData['refreshToken'];

          // 토큰을 사용하여 auth/test 엔드포인트로 요청을 보냄
          final testResponse = await http.post(
            Uri.parse('http://localhost:8080/auth/test'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $accessToken',
            },
          );

          if (testResponse.statusCode == 200) {
            _showSuccessDialog('로그인 성공!');
            Navigator.pushNamed(context, '/home');
          } else {
            _showErrorDialog('토큰 인증 실패');
          }
        } else {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          _showErrorDialog(responseData['message'] ?? '로그인 실패');
        }
      } catch (error) {
        _showErrorDialog('로그인 정보가 없습니다.');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('오류'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('확인'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('성공'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('확인'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formResponse,
      child: Column(
        children: [
          TextFormField(
            controller: _idController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Id",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'PassWord',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          submitButton(context),
          SizedBox(height: 10),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/signup'),
            child: const Text('Sign up'),
          ),
        ],
      ),
    );
  }

  // 폼 제출 버튼 위젯
  Widget submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _login,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: const Text(
          "Log in",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
