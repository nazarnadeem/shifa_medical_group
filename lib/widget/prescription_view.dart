import 'package:flutter/material.dart';

class PrescriptionView extends StatelessWidget {
  final prescription;
  final Function onTap;

  PrescriptionView({this.prescription, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Card(
            child: ListTile(
              leading: Text(
                prescription,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                Icons.remove_red_eye,
                color: Colors.green,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
