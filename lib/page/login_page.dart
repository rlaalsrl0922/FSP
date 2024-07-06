import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding : const EdgeInsets.all(12.0),
        child: ListView(children:[
          SizedBox(height: 100.0),
          Center(
          child: Text("Stock News", style: TextStyle(fontSize: 30))),
          SizedBox(height:20.0),
          LoginForm()
        ])
      )
    );
  }
}

// 재사용 할 수 있는 input field

class TextForm extends StatelessWidget {
  final String text;
  const TextForm(this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        SizedBox(height: 5.0),
        TextFormField(
            validator: (val) => val!.isEmpty ? "Please Fill" : null,
            obscureText: text == "Password" ? true : false,
            decoration: InputDecoration(
              hintText: "Enter $text",
            ))
      ],
    );
  }
}

class LoginForm extends StatelessWidget {
  final _formResponse = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formResponse,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
            decoration : InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: InputDecoration(
                hintText: 'PassWord',
                border: OutlineInputBorder()
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
        ));
  }

  // 폼 제출 버튼 위젯
  Widget submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formResponse.currentState!.validate()) {
          _formResponse.currentState!.save();
          Navigator.pushNamed(context, '/home');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        child: const Text(
          "Sign in",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}