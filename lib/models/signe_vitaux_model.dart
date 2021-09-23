class SigneVitauxModel {
  List<SignesVitaux> signesVitaux;

  SigneVitauxModel({this.signesVitaux});

  SigneVitauxModel.fromJson(Map<String, dynamic> json) {
    if (json['signes_vitaux'] != null) {
      // ignore: deprecated_member_use
      signesVitaux = new List<SignesVitaux>();
      json['signes_vitaux'].forEach((v) {
        signesVitaux.add(new SignesVitaux.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.signesVitaux != null) {
      data['signes_vitaux'] = this.signesVitaux.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SignesVitaux {
  String signeVitalId;
  String hopitalId;
  String titre;
  String signeVitalStatus;
  String dateEnregistrement;

  SignesVitaux(
      {this.signeVitalId,
      this.hopitalId,
      this.titre,
      this.signeVitalStatus,
      this.dateEnregistrement});

  SignesVitaux.fromJson(Map<String, dynamic> json) {
    signeVitalId = json['signe_vital_id'];
    hopitalId = json['hopital_id'];
    titre = json['titre'];
    signeVitalStatus = json['signe_vital_status'];
    dateEnregistrement = json['date_enregistrement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['signe_vital_id'] = this.signeVitalId;
    data['hopital_id'] = this.hopitalId;
    data['titre'] = this.titre;
    data['signe_vital_status'] = this.signeVitalStatus;
    data['date_enregistrement'] = this.dateEnregistrement;
    return data;
  }
}
