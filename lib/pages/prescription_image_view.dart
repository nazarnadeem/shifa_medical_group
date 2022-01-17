import 'dart:developer';

import 'package:flutter/material.dart';

class PrescriptionImageView extends StatelessWidget {
  String imagePath;
  String date;
  String time;

  PrescriptionImageView({@required this.imagePath,@required this.date,@required this.time});

  @override
  Widget build(BuildContext context) {
    log('url--> ${imagePath}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription Detail'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            width: double.maxFinite,
            child: Image.network(imagePath),
          ),
          Divider(thickness: 2,),
          Text("Prescription Uploded :- $date $time",style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600
          ),)
        ],
      ),
    );
  }
}
