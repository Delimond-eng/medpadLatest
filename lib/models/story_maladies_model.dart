class StoryMaladiesModel {
  Reponse reponse;

  StoryMaladiesModel({this.reponse});

  StoryMaladiesModel.fromJson(Map<String, dynamic> json) {
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
  List<Data> data;

  Reponse({this.status, this.data});

  Reponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      // ignore: deprecated_member_use
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String consultationHistoireMaladieId;
  String consultationId;
  String question;
  String reponse;
  String consultationHistoireMaladieStatus;
  String dateEnregistrement;

  Data(
      {this.consultationHistoireMaladieId,
      this.consultationId,
      this.question,
      this.reponse,
      this.consultationHistoireMaladieStatus,
      this.dateEnregistrement});

  Data.fromJson(Map<String, dynamic> json) {
    consultationHistoireMaladieId = json['consultation_histoire_maladie_id'];
    consultationId = json['consultation_id'];
    question = json['question'];
    reponse = json['reponse'];
    consultationHistoireMaladieStatus =
        json['consultation_histoire_maladie_status'];
    dateEnregistrement = json['date_enregistrement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['consultation_histoire_maladie_id'] =
        this.consultationHistoireMaladieId;
    data['consultation_id'] = this.consultationId;
    data['question'] = this.question;
    data['reponse'] = this.reponse;
    data['consultation_histoire_maladie_status'] =
        this.consultationHistoireMaladieStatus;
    data['date_enregistrement'] = this.dateEnregistrement;
    return data;
  }
}
