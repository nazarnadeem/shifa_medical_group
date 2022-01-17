import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shifa_medical_group/model/prescription_model.dart';
import 'package:shifa_medical_group/pages/image_picker.dart';
import 'package:shifa_medical_group/pages/prescription_image_view.dart';
import 'package:shifa_medical_group/pages/prescriptions.dart';
import 'package:shifa_medical_group/service/prescription_service.dart';
import 'package:shifa_medical_group/utils/constants.dart';
import 'package:shifa_medical_group/widget/prescription_listview.dart';
import 'package:shifa_medical_group/widget/widget.dart';

import 'profile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      log('Sucessful --> ');
    });
    isLoading.value = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //print("homeid--> ${widget.id}");
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
                  onPressed: () {},
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
                    Navigator.push(
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(),
                        ));
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: CarosolSlider(),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Card(
              child: Container(
                height: 100.0,
                child: Center(
                  child: ListTile(
                    leading: Icon(
                      Icons.file_copy_outlined,
                      color: Colors.red,
                      size: 40,
                    ),
                    title: Text("Upload your prescription"),
                    subtitle: Text('Get a call back'),
                    trailing: MaterialButton(
                        color: Colors.green,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImageDemo()));
                        },
                        child: Text("Upload")),
                  ),
                ),
              ),
            ),
          ),
          Text(
            'Your Prescription',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (key, builder, child) {
              return isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Flexible(
                      child: PrescriptionListView(prescriptionModel: prescriptionModel,),
                    );
            },
          ),
        ],
      ),
    );
  }
}
