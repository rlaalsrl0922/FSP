import 'package:flutter/material.dart';
import 'package:myapp/screens/IndividualScreen.dart';

/*

class IndividualPage extends StatelessWidget {
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

            ])
        ),
    );
  }
}

_sampleOne(int index, context) {
  return GestureDetector(
    onTap: () {
      // arguments에 값 전달
      Navigator.pushNamed(context, RouteName.detailView, arguments: index);
    },
    child: Container(),
  );
}

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // 이전 페이지에서 전달받은 값을 int sample에 초기화.
    int sample = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          sample.toString(),
        ),
      ),
      body: Column(
        children: [
          Text(
            'name: asdfdfer - asdfafbb${sample}',
            style: const TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
 */