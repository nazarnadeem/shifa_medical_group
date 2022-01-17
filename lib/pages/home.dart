import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:shifa_medical_group/pages/image_picker.dart';
import 'package:shifa_medical_group/pages/image_picker.dart';
import 'package:shifa_medical_group/pages/prescriptions.dart';
import 'package:shifa_medical_group/utils/constants.dart';

import 'profile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //print("homeid--> ${widget.id}");
    Widget carousel_slider = Container(
      height: 180.0,
      child: Carousel(
        dotBgColor: Colors.transparent,
        dotSize: 0,
        autoplay: true,
        images: [
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            child: Image.network(
              "https://cdn.grabon.in/gograbon/images/web-images/uploads/1618566499779/medicines-offers.jpg",
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            child: Image.network(
              "https://cdn.grabon.in/gograbon/images/web-images/uploads/1618566499779/medicines-offers.jpg",
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            child: Image.network(
              "https://cdn.grabon.in/gograbon/images/web-images/uploads/1618566499779/medicines-offers.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
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
                  },
                  icon: Icon(Icons.home, color: Colors.green,),
                  iconSize: 40,
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Prescriptions(),),);
                  },
                  icon: Icon(Icons.file_copy, color: Colors.green,),
                  iconSize: 30,
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(),));
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
        child: ListView(children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: carousel_slider,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Card(
              child: Container(
                height: 100.0,
                child: Flexible(
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
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImageDemo()));
                          },
                          child: Text("Upload")),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Card(
              child: ListTile(
                leading: Text(
                  "Prescription 1",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
                  Icons.remove_red_eye,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Card(
              child: ListTile(
                leading: Text(
                  "Prescription 1",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
                  Icons.remove_red_eye,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Card(
              child: ListTile(
                leading: Text(
                  "Prescription 1",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
                  Icons.remove_red_eye,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Card(
              child: ListTile(
                leading: Text(
                  "Prescription 1",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
                  Icons.remove_red_eye,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Card(
              child: ListTile(
                leading: Text(
                  "Prescription 1",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
                  Icons.remove_red_eye,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Card(
              child: ListTile(
                leading: Text(
                  "Prescription 1",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
                  Icons.remove_red_eye,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Card(
              child: ListTile(
                leading: Text(
                  "Prescription 1",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
                  Icons.remove_red_eye,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Card(
              child: ListTile(
                leading: Text(
                  "Prescription 1",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
                  Icons.remove_red_eye,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
