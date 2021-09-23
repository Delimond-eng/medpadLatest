class HospitalBedModel {
  List<Lits> lits;

  HospitalBedModel({this.lits});

  HospitalBedModel.fromJson(Map<String, dynamic> json) {
    if (json['lits'] != null) {
      // ignore: deprecated_member_use
      lits = new List<Lits>();
      json['lits'].forEach((v) {
        lits.add(new Lits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lits != null) {
      data['lits'] = this.lits.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lits {
  String litId;
  String hopitalId;
  String designation;
  String litStatus;
  String dateEnregistrement;
  bool isChecked = false;

  Lits(
      {this.litId,
      this.hopitalId,
      this.designation,
      this.litStatus,
      this.dateEnregistrement});

  Lits.fromJson(Map<String, dynamic> json) {
    litId = json['lit_id'];
    hopitalId = json['hopital_id'];
    designation = json['designation'];
    litStatus = json['lit_status'];
    dateEnregistrement = json['date_enregistrement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lit_id'] = this.litId;
    data['hopital_id'] = this.hopitalId;
    data['designation'] = this.designation;
    data['lit_status'] = this.litStatus;
    data['date_enregistrement'] = this.dateEnregistrement;
    return data;
  }
}
