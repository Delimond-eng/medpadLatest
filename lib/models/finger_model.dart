class FingersModel {
  List<Empreintes> empreintes;

  FingersModel({this.empreintes});

  FingersModel.fromJson(Map<String, dynamic> json) {
    if (json['empreintes'] != null) {
      empreintes = new List<Empreintes>();
      json['empreintes'].forEach((v) {
        empreintes.add(new Empreintes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.empreintes != null) {
      data['empreintes'] = this.empreintes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Empreintes {
  String patientId;
  String empreinteId;
  String empreinte1;
  String empreinte2;
  String empreinte3;

  Empreintes(
      {this.patientId,
        this.empreinteId,
        this.empreinte1,
        this.empreinte2,
        this.empreinte3});

  Empreintes.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    empreinteId = json['empreinte_id'];
    empreinte1 = json['empreinte_1'];
    empreinte2 = json['empreinte_2'];
    empreinte3 = json['empreinte_3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_id'] = this.patientId;
    data['empreinte_id'] = this.empreinteId;
    data['empreinte_1'] = this.empreinte1;
    data['empreinte_2'] = this.empreinte2;
    data['empreinte_3'] = this.empreinte3;
    return data;
  }
}