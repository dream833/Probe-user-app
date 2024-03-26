import 'package:flutter/material.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';

class HospitalView extends StatelessWidget {
  const HospitalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: SmallText(
            text: 'Hospital',
            fontSize: 15,
            fontWeight: FontWeight.w500,
            textColor: Colors.grey.shade700),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('Comming Soon'),
          )
        ],
      ),
    );
  }
}
