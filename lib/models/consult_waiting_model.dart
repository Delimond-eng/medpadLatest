class ConsultationsWaitingView {
  List<Consultations> consultations;

  ConsultationsWaitingView({this.consultations});

  ConsultationsWaitingView.fromJson(Map<String, dynamic> json) {
    if (json['consultations'] != null) {
      // ignore: deprecated_member_use
      consultations = new List<Consultations>();
      json['consultations'].forEach((v) {
        consultations.add(new Consultations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.consultations != null) {
      data['consultations'] =
          this.consultations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Consultations {
  String consultationId;
  String patientId;
  String patientNom;
  String plainte;
  int completion;
  List<ConsultSignesVitaux> signesVitaux;
  List<ConsultHistoireMaladie> histoireMaladie;
  List<ConsultAntecedents> antecedents;
  List<ConsultExamensPhysique> examensPhysique;
  List<ConsultExamensLaboratoire> examensLaboratoire;
  List<ConsultPrescriptions> prescriptions;

  Consultations(
      {this.consultationId,
      this.patientId,
      this.patientNom,
      this.plainte,
      this.completion,
      this.signesVitaux,
      this.histoireMaladie,
      this.antecedents,
      this.examensPhysique,
      this.examensLaboratoire,
      this.prescriptions});

  Consultations.fromJson(Map<String, dynamic> json) {
    consultationId = json['consultation_id'];
    patientId = json['patient_id'];
    patientNom = json['patient_nom'];
    plainte = json['plainte'];
    completion = json['completion'];
    if (json['signes_vitaux'] != null) {
      // ignore: deprecated_member_use
      signesVitaux = new List<ConsultSignesVitaux>();
      json['signes_vitaux'].forEach((v) {
        signesVitaux.add(new ConsultSignesVitaux.fromJson(v));
      });
    }
    if (json['histoire_maladie'] != null) {
      // ignore: deprecated_member_use
      histoireMaladie = new List<ConsultHistoireMaladie>();
      json['histoire_maladie'].forEach((v) {
        histoireMaladie.add(new ConsultHistoireMaladie.fromJson(v));
      });
    }
    if (json['antecedents'] != null) {
      // ignore: deprecated_member_use
      antecedents = new List<ConsultAntecedents>();
      json['antecedents'].forEach((v) {
        antecedents.add(new ConsultAntecedents.fromJson(v));
      });
    }
    if (json['examens_physique'] != null) {
      // ignore: deprecated_member_use
      examensPhysique = new List<ConsultExamensPhysique>();
      json['examens_physique'].forEach((v) {
        examensPhysique.add(new ConsultExamensPhysique.fromJson(v));
      });
    }
    if (json['examens_laboratoire'] != null) {
      // ignore: deprecated_member_use
      examensLaboratoire = new List<ConsultExamensLaboratoire>();
      json['examens_laboratoire'].forEach((v) {
        examensLaboratoire.add(new ConsultExamensLaboratoire.fromJson(v));
      });
    }

    if(json['prescriptions'] != null){
      prescriptions = new List<ConsultPrescriptions>();
      json['prescriptions'].forEach((v){
        prescriptions.add(new ConsultPrescriptions.fromJson(v));
      });
    }


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['consultation_id'] = this.consultationId;
    data['patient_id'] = this.patientId;
    data['patient_nom'] = this.patientNom;
    data['plainte'] = this.plainte;
    data['completion'] = this.completion;
    if (this.signesVitaux != null) {
      data['signes_vitaux'] = this.signesVitaux.map((v) => v.toJson()).toList();
    }
    if (this.histoireMaladie != null) {
      data['histoire_maladie'] =
          this.histoireMaladie.map((v) => v.toJson()).toList();
    }
    if (this.antecedents != null) {
      data['antecedents'] = this.antecedents.map((v) => v.toJson()).toList();
    }
    if (this.examensPhysique != null) {
      data['examens_physique'] =
          this.examensPhysique.map((v) => v.toJson()).toList();
    }
    if (this.examensLaboratoire != null) {
      data['examens_laboratoire'] =
          this.examensLaboratoire.map((v) => v.toJson()).toList();
    }

    if(this.prescriptions != null){
      data['prescriptions'] = this.prescriptions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConsultSignesVitaux {
  String titre;
  String signeVitalValeur;

  ConsultSignesVitaux({this.titre, this.signeVitalValeur});

  ConsultSignesVitaux.fromJson(Map<String, dynamic> json) {
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

class ConsultHistoireMaladie {
  String consultationHistoireMaladieId;
  String consultationId;
  String question;
  String reponse;
  String consultationHistoireMaladieStatus;
  String dateEnregistrement;

  ConsultHistoireMaladie(
      {this.consultationHistoireMaladieId,
      this.consultationId,
      this.question,
      this.reponse,
      this.consultationHistoireMaladieStatus,
      this.dateEnregistrement});

  ConsultHistoireMaladie.fromJson(Map<String, dynamic> json) {
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

class ConsultAntecedents {
  String consultationAntecedentId;
  String consultationId;
  String antecedentType;
  String question;
  String reponse;
  String consultationAntecedentStatus;
  String dateEnregistrement;

  ConsultAntecedents(
      {this.consultationAntecedentId,
      this.consultationId,
      this.antecedentType,
      this.question,
      this.reponse,
      this.consultationAntecedentStatus,
      this.dateEnregistrement});

  ConsultAntecedents.fromJson(Map<String, dynamic> json) {
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

class ConsultExamensPhysique {
  String consultationExamenPhysiqueId;
  String consultationId;
  String donneeLabel;
  String donneeValeur;
  String consultationExamenPhysiqueStatus;
  String dateEnregistrement;

  ConsultExamensPhysique(
      {this.consultationExamenPhysiqueId,
      this.consultationId,
      this.donneeLabel,
      this.donneeValeur,
      this.consultationExamenPhysiqueStatus,
      this.dateEnregistrement});

  ConsultExamensPhysique.fromJson(Map<String, dynamic> json) {
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

class ConsultExamensLaboratoire {
  String examenLaboratoireId;
  String examen;
  String resultat;
  String consultationId;
  String dateEnregistrement;

  ConsultExamensLaboratoire(
      {this.examenLaboratoireId,
      this.examen,
      this.resultat,
      this.consultationId,
      this.dateEnregistrement});

  ConsultExamensLaboratoire.fromJson(Map<String, dynamic> json) {
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

class ConsultPrescriptions{
  String prescriptionId;
  String consultationId;
  String prescription;
  String dosage;
  String prescriptionStatus;
  String dateEnregistrement;

  ConsultPrescriptions(
      {this.prescriptionId,
        this.consultationId,
        this.prescription,
        this.dosage,
        this.prescriptionStatus,
        this.dateEnregistrement});

  ConsultPrescriptions.fromJson(Map<String, dynamic> json) {
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
