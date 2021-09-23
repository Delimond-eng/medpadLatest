class ConsultationModel {
  Reponse reponse;

  ConsultationModel({this.reponse});

  ConsultationModel.fromJson(Map<String, dynamic> json) {
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
  String consultationId;
  List<ConsultationSignesVitaux> signesVitaux;

  Reponse({this.status, this.consultationId, this.signesVitaux});

  Reponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    consultationId = json['consultation_id'];
    if (json['signes_vitaux'] != null) {
      // ignore: deprecated_member_use
      signesVitaux = new List<ConsultationSignesVitaux>();
      json['signes_vitaux'].forEach((v) {
        signesVitaux.add(new ConsultationSignesVitaux.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['consultation_id'] = this.consultationId;
    if (this.signesVitaux != null) {
      data['signes_vitaux'] = this.signesVitaux.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConsultationSignesVitaux {
  String titre;
  String signeVitalValeur;

  ConsultationSignesVitaux({this.titre, this.signeVitalValeur});

  ConsultationSignesVitaux.fromJson(Map<String, dynamic> json) {
    titre = json['titre'];
    signeVitalValeur = json['signe_vital_valeur'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titre'] = this.titre;
    data['signe_vital_valeur'] = this.signeVitalValeur;
    return data;
  }
}
