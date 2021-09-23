class ConsultationExamenPhysiqueModel {
  Reponse reponse;

  ConsultationExamenPhysiqueModel({this.reponse});

  ConsultationExamenPhysiqueModel.fromJson(Map<String, dynamic> json) {
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
  List<ExamensPhysique> examensPhysique;

  Reponse({this.status, this.examensPhysique});

  Reponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['examens_physique'] != null) {
      // ignore: deprecated_member_use
      examensPhysique = new List<ExamensPhysique>();
      json['examens_physique'].forEach((v) {
        examensPhysique.add(new ExamensPhysique.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.examensPhysique != null) {
      data['examens_physique'] =
          this.examensPhysique.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExamensPhysique {
  String consultationExamenPhysiqueId;
  String consultationId;
  String donneeLabel;
  String donneeValeur;
  String consultationExamenPhysiqueStatus;
  String dateEnregistrement;

  ExamensPhysique(
      {this.consultationExamenPhysiqueId,
      this.consultationId,
      this.donneeLabel,
      this.donneeValeur,
      this.consultationExamenPhysiqueStatus,
      this.dateEnregistrement});

  ExamensPhysique.fromJson(Map<String, dynamic> json) {
    consultationExamenPhysiqueId = json['consultation_examen_physique_id'];
    consultationId = json['consultation_id'];
    donneeLabel = json['donnee_label'];
    donneeValeur = json['donnee_valeur'];
    consultationExamenPhysiqueStatus =
        json['consultation_examen_physique_status'];
    dateEnregistrement = json['date_enregistrement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['consultation_examen_physique_id'] = this.consultationExamenPhysiqueId;
    data['consultation_id'] = this.consultationId;
    data['donnee_label'] = this.donneeLabel;
    data['donnee_valeur'] = this.donneeValeur;
    data['consultation_examen_physique_status'] =
        this.consultationExamenPhysiqueStatus;
    data['date_enregistrement'] = this.dateEnregistrement;
    return data;
  }
}
