class ExamensEnCoursModel {
  List<ExamensData> examensData;

  ExamensEnCoursModel({this.examensData});

  ExamensEnCoursModel.fromJson(Map<String, dynamic> json) {
    if (json['examens_data'] != null) {
      // ignore: deprecated_member_use
      examensData = new List<ExamensData>();
      json['examens_data'].forEach((v) {
        examensData.add(new ExamensData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.examensData != null) {
      data['examens_data'] = this.examensData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExamensData {
  String consultationId;
  List<Examens> examens;

  ExamensData({this.consultationId, this.examens});

  ExamensData.fromJson(Map<String, dynamic> json) {
    consultationId = json['consultation_id'];
    if (json['examens'] != null) {
      // ignore: deprecated_member_use
      examens = new List<Examens>();
      json['examens'].forEach((v) {
        examens.add(new Examens.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['consultation_id'] = this.consultationId;
    if (this.examens != null) {
      data['examens'] = this.examens.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Examens {
  String examenLaboratoireId;
  String examen;
  String resultat;
  String consultationId;
  String dateEnregistrement;

  Examens(
      {this.examenLaboratoireId,
      this.examen,
      this.resultat,
      this.consultationId,
      this.dateEnregistrement});

  Examens.fromJson(Map<String, dynamic> json) {
    examenLaboratoireId = json['examen_laboratoire_id'];
    examen = json['examen'];
    resultat = json['resultat'];
    consultationId = json['consultation_id'];
    dateEnregistrement = json['date_enregistrement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['examen_laboratoire_id'] = this.examenLaboratoireId;
    data['examen'] = this.examen;
    data['resultat'] = this.resultat;
    data['consultation_id'] = this.consultationId;
    data['date_enregistrement'] = this.dateEnregistrement;
    return data;
  }
}
