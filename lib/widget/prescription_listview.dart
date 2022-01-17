import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shifa_medical_group/App_constant.dart';
import 'package:shifa_medical_group/model/prescription_model.dart';
import 'package:shifa_medical_group/pages/prescription_image_view.dart';
import 'package:shifa_medical_group/widget/prescription_view.dart';

class PrescriptionListView extends StatelessWidget {
  PrescriptionModel prescriptionModel;
   PrescriptionListView({@required this.prescriptionModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: prescriptionModel.data.prescription.length,
      itemBuilder: (BuildContext context, int index) => PrescriptionView(
        prescription: "Prescription ${index + 1}",
        onTap: () {
          DateTime now = DateTime.parse(prescriptionModel.data.prescription[index].createdAt);
          String formattedDate = DateFormat('dd-MMM-yyyy  hh:mm a').format(now);
          final date = formattedDate
              .substring(
            0,
            formattedDate.indexOf(' '),
          )
              .toString();
          final time = formattedDate
              .substring(
            formattedDate.indexOf(' ') + 1,
          )
              .toString();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PrescriptionImageView(
                date: date,
                time: time,
                imagePath: AppConstant.prescriptionImagePath + prescriptionModel.data.prescription[index].prescription,
              ),
            ),
          );
        },
      ),
    );
  }
}
