import 'dart:convert';
import 'dart:developer';

import 'package:shifa_medical_group/App_constant.dart';
import 'package:http/http.dart' as http;
import 'package:shifa_medical_group/model/prescription_model.dart';

class PrescriptionService {
  static Future<PrescriptionModel> getPrescription() async {
    final url = AppConstant.baseUrl + 'medical_app/manage/api/prescription/all/?X-Api-Key=' + AppConstant.xApikey;
    try {
      final respone = await http.get(url);
      if (respone.statusCode == 200) {
        PrescriptionModel prescriptionModel = PrescriptionModel();
        final result = json.decode(respone.body);
        prescriptionModel = PrescriptionModel.fromJson(result);
        return prescriptionModel;
      }
    } catch (error) {
      log("getPrescription error--> $getPrescription");
      rethrow;
    }
  }
}
