import 'package:flutter/material.dart';
import 'package:shifa_medical_group/utils/constants.dart';

import 'home.dart';
import 'profile.dart';
class Prescriptions extends StatefulWidget {

  @override
  _PrescriptionsState createState() => _PrescriptionsState();
}

class _PrescriptionsState extends State<Prescriptions> {
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
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),),);
                  },
                  icon: Icon(Icons.home, color: Colors.green,),
                  iconSize: 40,
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Prescriptions(),),);
                  },
                  icon: Icon(Icons.file_copy, color: Colors.green,),
                  iconSize: 30,
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile(),));
                  },
                  icon: Icon(Icons.person, color: Colors.green,),
                  iconSize: 40,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child:ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) => SinglePrescription(
              prescription: "Prescription",
            )),
      ),
    );
  }
}

class SinglePrescription extends StatelessWidget {
  final prescription;
  SinglePrescription({this.prescription, });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          child: ListTile(
            leading: Text(
              prescription,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.remove_red_eye,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}

