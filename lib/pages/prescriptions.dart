import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shifa_medical_group/App_constant.dart';
import 'package:shifa_medical_group/model/prescription_model.dart';
import 'package:shifa_medical_group/pages/prescription_image_view.dart';
import 'package:shifa_medical_group/service/prescription_service.dart';
import 'package:shifa_medical_group/utils/constants.dart';
import 'package:shifa_medical_group/widget/prescription_listview.dart';

import 'home.dart';
import 'profile.dart';

class Prescriptions extends StatefulWidget {
  @override
  _PrescriptionsState createState() => _PrescriptionsState();
}

class _PrescriptionsState extends State<Prescriptions> {
  PrescriptionModel prescriptionModel = PrescriptionModel();
  ValueNotifier isLoading = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    isLoading.value = true;
    await PrescriptionService.getPrescription().then((value) {
      prescriptionModel = value;
    });
    isLoading.value = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.green,
        title: Text(appTitle),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BottomAppBar(
          elevation: 0,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.home,
                    color: Colors.green,
                  ),
                  iconSize: 40,
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Prescriptions(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.file_copy,
                    color: Colors.green,
                  ),
                  iconSize: 30,
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Profile(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                  iconSize: 40,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: ValueListenableBuilder(
          valueListenable: isLoading,
          builder: (key, builder, child) {
            return isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                :  PrescriptionListView(prescriptionModel: prescriptionModel,);
          },
        ),
      ),
    );
  }
}


