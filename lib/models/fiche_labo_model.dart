class LaboFicheModel {
  List<Fiche> fiche;

  LaboFicheModel({this.fiche});

  LaboFicheModel.fromJson(Map<String, dynamic> json) {
    if (json['fiche'] != null) {
      // ignore: deprecated_member_use
      fiche = new List<Fiche>();
      json['fiche'].forEach((v) {
        fiche.add(new Fiche.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fiche != null) {
      data['fiche'] = this.fiche.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fiche {
  String ficheLaboratoireId;
  String hopitalId;
  String examen;
  String ficheLaboratoireStatus;
  String dateEnregistrement;
  bool isSelected = false;

  Fiche(
      {this.ficheLaboratoireId,
      this.hopitalId,
      this.examen,
      this.ficheLaboratoireStatus,
      this.dateEnregistrement});

  Fiche.fromJson(Map<String, dynamic> json) {
    ficheLaboratoireId = json['fiche_laboratoire_id'];
    hopitalId = json['hopital_id'];
    examen = json['examen'];
    ficheLaboratoireStatus = json['fiche_laboratoire_status'];
    dateEnregistrement = json['date_enregistrement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fiche_laboratoire_id'] = this.ficheLaboratoireId;
    data['hopital_id'] = this.hopitalId;
    data['examen'] = this.examen;
    data['fiche_laboratoire_status'] = this.ficheLaboratoireStatus;
    data['date_enregistrement'] = this.dateEnregistrement;
    return data;
  }
}
