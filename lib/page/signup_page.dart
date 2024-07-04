import 'package:flutter/material.dart';


class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(children: [
              SizedBox(height: 100.0),
              SignupFormet(),
            ])));
  }
}


class SignupFormet extends StatefulWidget {
  @override
  State<SignupFormet> createState() => _SignupFormetState();
}

class _SignupFormetState extends State<SignupFormet> {
  final _signupFormKey = GlobalKey<FormState>();
  String _route = '';
  String _id = '';
  String _password = '';
  String _nickname = '';


  @override
  Widget build(BuildContext context) {
    return Form(
        key: _signupFormKey,
        child: Column(
          children: [
            SizedBox(height: 5.0),
            CustomTextFormField("Id"),
            SizedBox(height: 15.0),
            CustomTextFormField("Password"),
            SizedBox(height: 15.0),
            CustomTextFormField("Nickname"),
            SizedBox(height: 15),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[submitButton(context),
            SizedBox(width : 10),
            TextButton(
              onPressed: () => {Navigator.pushNamed(context, '/login')},
              child: const Text('Login'),
            )]),
          ],
        ));
  }


  // input
  Widget CustomTextFormField(text) {
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
            onSaved: (value) => {
              text == 'Email'
                  ? _id = value!
                  : text == 'Password'
                  ? _password = value!
                  : _nickname = value!
            })
      ],
    );
  }

  Widget submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_signupFormKey.currentState!.validate()) {
          _signupFormKey.currentState!.save();
          debugPrint('$_id, $_password, $_nickname Trying Sign Up');
          Navigator.pushNamed(context, '/home');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        child: const Text(
          "SignUp",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

// 폼 제출 버튼 위젯
/*
  Widget submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_signupFormKey.currentState!.validate()) {
          _signupFormKey.currentState!.save();

          final response = await http.post(
              Uri.parse('http://10.0.2.2:3000/auth/register'),
              body: {"id": _id, "nickname": _nickname, "pwd": _password});
          if (response.statusCode == 200) {
            // 회원가입 성공
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text('close'))
                  ],
                  title: Text('Stock newses'),
                  content: Text('SignUp Complete!'),
                ));
          } else {
            // 회원가입 실패
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('close'))
                  ],
                  title: Text('Stock newses'),
                  content: Text('SignUp Failed : already SignUped'),
                ));
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        child: const Text(
          "SignUp",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }*/
}