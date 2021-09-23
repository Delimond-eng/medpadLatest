class ConsultationPrescriptionModel {
  Reponse reponse;

  ConsultationPrescriptionModel({this.reponse});

  ConsultationPrescriptionModel.fromJson(Map<String, dynamic> json) {
    reponse =
        json['reponse'] != null ? new Reponse.fromJson(json['reponse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reponse != null) {
      data['reponse'] = this.reponse.toJson();
    }
    return data;
  }
}

class Reponse {
  String status;
  List<Prescriptions> prescriptions;

  Reponse({this.status, this.prescriptions});

  Reponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['prescriptions'] != null) {
      // ignore: deprecated_member_use
      prescriptions = new List<Prescriptions>();
      json['prescriptions'].forEach((v) {
        prescriptions.add(new Prescriptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.prescriptions != null) {
      data['prescriptions'] =
          this.prescriptions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prescriptions {
  String prescriptionId;
  String consultationId;
  String prescription;
  String dosage;
  String prescriptionStatus;
  String dateEnregistrement;

  Prescriptions(
      {this.prescriptionId,
      this.consultationId,
      this.prescription,
      this.dosage,
      this.prescriptionStatus,
      this.dateEnregistrement});

  Prescriptions.fromJson(Map<String, dynamic> json) {
    prescriptionId = json['prescription_id'];
    consultationId = json['consultation_id'];
    prescription = json['prescription'];
    dosage = json['dosage'];
    prescriptionStatus = json['prescription_status'];
    dateEnregistrement = json['date_enregistrement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prescription_id'] = this.prescriptionId;
    data['consultation_id'] = this.consultationId;
    data['prescription'] = this.prescription;
    data['dosage'] = this.dosage;
    data['prescription_status'] = this.prescriptionStatus;
    data['date_enregistrement'] = this.dateEnregistrement;
    return data;
  }
}
