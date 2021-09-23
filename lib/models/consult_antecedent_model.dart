class ConsultationAntecedentModel {
  Reponse reponse;

  ConsultationAntecedentModel({this.reponse});

  ConsultationAntecedentModel.fromJson(Map<String, dynamic> json) {
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
  List<Antecedents> antecedents;

  Reponse({this.status, this.antecedents});

  Reponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['antecedents'] != null) {
      // ignore: deprecated_member_use
      antecedents = new List<Antecedents>();
      json['antecedents'].forEach((v) {
        antecedents.add(new Antecedents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.antecedents != null) {
      data['antecedents'] = this.antecedents.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Antecedents {
  String consultationAntecedentId;
  String consultationId;
  String antecedentType;
  String question;
  String reponse;
  String consultationAntecedentStatus;
  String dateEnregistrement;

  Antecedents(
      {this.consultationAntecedentId,
      this.consultationId,
      this.antecedentType,
      this.question,
      this.reponse,
      this.consultationAntecedentStatus,
      this.dateEnregistrement});

  Antecedents.fromJson(Map<String, dynamic> json) {
    consultationAntecedentId = json['consultation_antecedent_id'];
    consultationId = json['consultation_id'];
    antecedentType = json['antecedent_type'];
    question = json['question'];
    reponse = json['reponse'];
    consultationAntecedentStatus = json['consultation_antecedent_status'];
    dateEnregistrement = json['date_enregistrement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['consultation_antecedent_id'] = this.consultationAntecedentId;
    data['consultation_id'] = this.consultationId;
    data['antecedent_type'] = this.antecedentType;
    data['question'] = this.question;
    data['reponse'] = this.reponse;
    data['consultation_antecedent_status'] = this.consultationAntecedentStatus;
    data['date_enregistrement'] = this.dateEnregistrement;
    return data;
  }
}
