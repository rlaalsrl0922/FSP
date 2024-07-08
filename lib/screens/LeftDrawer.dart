import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';



class LeftDrawer extends StatefulWidget {

  @override
  State<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer>{
  String _nickname ='';

  @override
  void initState(){
    super.initState();
    DateTime news_date = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar : AppBar(
        title: Row(
            children: [const Text('Top100 page')]
        )
    ), body: Center(child: Text('Top100 Page')),
        drawer: Drawer(
            child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    child: Container(
                      child: Text('Information'),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                      )
                    ),
                  ),
                  ListTile(
                    title: Text('My Page'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                      title: Text('Data Source'),
                      onTap: () {
                        _showAlertDialog(context, 'Sources Information',
                            [{'text' : 'This price and the source of the news is Yahoo Finance'}]);
                      }),
                  ListTile(
                    title: Text('Contact'),
                    onTap: () {
                      _showAlertDialog(context, 'Developer Info',[
                        {'text': 'Github ', 'url': 'https://github.com/rlaalsrl0922'},
                        {'text': 'Email ', 'url': 'mailto:rlaalsrl0922@khu.ac.kr'},
                        {'text': 'LinkedIn ', 'url': 'https://www.linkedin.com/in/minki-kim-13892'},
                        {'text': 'Resume ', 'url': 'https://superficial-waiter-55e.notion.site/1feb56ba63c8415e83d3302768f454bf?pvs=4'},]);
                    },
                  ),])));
  }
  void _showAlertDialog(BuildContext context, String title, List<Map<String, String>> contentList) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: contentList.map((content) {
                return GestureDetector(
                  onTap: () async {
                    final String url = content['url']!;
                    launchUrlString(url);
                  },
                  child: Text(
                    content['text'] ?? '',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                );
              }).toList(),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
        },
    );
  }
}