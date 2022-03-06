import 'package:cov19_tracker/maindata.dart';
import 'package:flutter/material.dart';

class FAQSPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQS'),
      ),
      body: ListView.builder(
          itemCount: MainData.questionAnswers.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              title: Text(MainData.questionAnswers[index]['question']),
              children: [
                Text(MainData.questionAnswers[index]['answer'])
              ],
            );
          }),
    );
  }
}
