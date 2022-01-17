class PrescriptionModel {
  bool status;
  String message;
  Data data;
  int total;

  PrescriptionModel({this.status, this.message, this.data, this.total});

  PrescriptionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['total'] = this.total;
    return data;
  }
}

class Data {
  List<Prescription> prescription;

  Data({this.prescription});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['prescription'] != null) {
      prescription = <Prescription>[];
      json['prescription'].forEach((v) {
        prescription.add(new Prescription.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.prescription != null) {
      data['prescription'] = this.prescription.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prescription {
  String id;
  String userId;
  String prescription;
  String createdAt;

  Prescription({this.id, this.userId, this.prescription, this.createdAt});

  Prescription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    prescription = json['prescription'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['prescription'] = this.prescription;
    data['created_at'] = this.createdAt;
    return data;
  }
}
