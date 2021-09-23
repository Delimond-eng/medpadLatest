class PatientDocModel {
  Patient patient;

  PatientDocModel({this.patient});

  PatientDocModel.fromJson(Map<String, dynamic> json) {
    patient =
    json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patient != null) {
      data['patient'] = this.patient.toJson();
    }
    return data;
  }
}

class Patient {
  String patientId;
  String nom;
  String sexe;
  String dateNaissance;
  String profession;
  String email;
  String telephone;
  String adresseId;
  String empreinteId;
  String patientStatus;
  String dateEnregistrement;
  List<Antecedents> antecedents;
  List<PremierSoins> premierSoins;
  List<Consultations> consultations;

  Patient(
      {this.patientId,
        this.nom,
        this.sexe,
        this.dateNaissance,
        this.profession,
        this.email,
        this.telephone,
        this.adresseId,
        this.empreinteId,
        this.patientStatus,
        this.dateEnregistrement,
        this.antecedents,
        this.premierSoins,
        this.consultations});

  Patient.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    nom = json['nom'];
    sexe = json['sexe'];
    dateNaissance = json['date_naissance'];
    profession = json['profession'];
    email = json['email'];
    telephone = json['telephone'];
    adresseId = json['adresse_id'];
    empreinteId = json['empreinte_id'];
    patientStatus = json['patient_status'];
    dateEnregistrement = json['date_enregistrement'];
    if (json['antecedents'] != null) {
      antecedents = new List<Antecedents>();
      json['antecedents'].forEach((v) {
        antecedents.add(new Antecedents.fromJson(v));
      });
    }
    if (json['premier_soins'] != null) {
      premierSoins = new List<PremierSoins>();
      json['premier_soins'].forEach((v) {
        premierSoins.add(new PremierSoins.fromJson(v));
      });
    }
    if (json['consultations'] != null) {
      consultations = new List<Consultations>();
      json['consultations'].forEach((v) {
        consultations.add(new Consultations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_id'] = this.patientId;
    data['nom'] = this.nom;
    data['sexe'] = this.sexe;
    data['date_naissance'] = this.dateNaissance;
    data['profession'] = this.profession;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['adresse_id'] = this.adresseId;
    data['empreinte_id'] = this.empreinteId;
    data['patient_status'] = this.patientStatus;
    data['date_enregistrement'] = this.dateEnregistrement;
    if (this.antecedents != null) {
      data['antecedents'] = this.antecedents.map((v) => v.toJson()).toList();
    }
    if (this.premierSoins != null) {
      data['premier_soins'] = this.premierSoins.map((v) => v.toJson()).toList();
    }
    if (this.consultations != null) {
      data['consultations'] =
          this.consultations.map((v) => v.toJson()).toList();
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

class PremierSoins {
  String premierSoinId;
  String hopitalId;
  String patientId;
  String traitement;
  String dosage;
  String premierSoinStatus;
  String dateEnregistrement;

  PremierSoins(
      {this.premierSoinId,
        this.hopitalId,
        this.patientId,
        this.traitement,
        this.dosage,
        this.premierSoinStatus,
        this.dateEnregistrement});

  PremierSoins.fromJson(Map<String, dynamic> json) {
    premierSoinId = json['premier_soin_id'];
    hopitalId = json['hopital_id'];
    patientId = json['patient_id'];
    traitement = json['traitement'];
    dosage = json['dosage'];
    premierSoinStatus = json['premier_soin_status'];
    dateEnregistrement = json['date_enregistrement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['premier_soin_id'] = this.premierSoinId;
    data['hopital_id'] = this.hopitalId;
    data['patient_id'] = this.patientId;
    data['traitement'] = this.traitement;
    data['dosage'] = this.dosage;
    data['premier_soin_status'] = this.premierSoinStatus;
    data['date_enregistrement'] = this.dateEnregistrement;
    return data;
  }
}

class Consultations {
  String consultationId;
  String patientId;
  String patientNom;
  String plainte;
  String dateEnregistrement;
  int completion;
  List<SignesVitaux> signesVitaux;
  List<HistoireMaladie> histoireMaladie;
  List<Antecedents> antecedents;
  List<ExamensPhysique> examensPhysique;
  List<ExamensLaboratoire> examensLaboratoire;
  List<Prescriptions> prescriptions;

  Consultations(
      {this.consultationId,
        this.patientId,
        this.patientNom,
        this.plainte,
        this.dateEnregistrement,
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
    dateEnregistrement = json['date_enregistrement'];
    completion = json['completion'];
    if (json['signes_vitaux'] != null) {
      signesVitaux = new List<SignesVitaux>();
      json['signes_vitaux'].forEach((v) {
        signesVitaux.add(new SignesVitaux.fromJson(v));
      });
    }
    if (json['histoire_maladie'] != null) {
      histoireMaladie = new List<HistoireMaladie>();
      json['histoire_maladie'].forEach((v) {
        histoireMaladie.add(new HistoireMaladie.fromJson(v));
      });
    }
    if (json['antecedents'] != null) {
      antecedents = new List<Antecedents>();
      json['antecedents'].forEach((v) {
        antecedents.add(new Antecedents.fromJson(v));
      });
    }
    if (json['examens_physique'] != null) {
      examensPhysique = new List<ExamensPhysique>();
      json['examens_physique'].forEach((v) {
        examensPhysique.add(new ExamensPhysique.fromJson(v));
      });
    }
    if (json['examens_laboratoire'] != null) {
      examensLaboratoire = new List<ExamensLaboratoire>();
      json['examens_laboratoire'].forEach((v) {
        examensLaboratoire.add(new ExamensLaboratoire.fromJson(v));
      });
    }
    if (json['prescriptions'] != null) {
      prescriptions = new List<Prescriptions>();
      json['prescriptions'].forEach((v) {
        prescriptions.add(new Prescriptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['consultation_id'] = this.consultationId;
    data['patient_id'] = this.patientId;
    data['patient_nom'] = this.patientNom;
    data['plainte'] = this.plainte;
    data['date_enregistrement'] = this.dateEnregistrement;
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
    if (this.prescriptions != null) {
      data['prescriptions'] =
          this.prescriptions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SignesVitaux {
  String titre;
  String signeVitalValeur;

  SignesVitaux({this.titre, this.signeVitalValeur});

  SignesVitaux.fromJson(Map<String, dynamic> json) {
    titre = json['titre'];
    signeVitalValeur = json['signe_vital_valeur'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titre'] = this.titre;
    data['signe_vital_valeur'] = this.signeVitalValeur;
    return data;
  }

  String getIndex(int index) {
    switch (index) {
      case 0:
        return titre.toLowerCase();
      case 1:
        return signeVitalValeur.toLowerCase();
    }
    return '';
  }
}

class HistoireMaladie {
  String consultationHistoireMaladieId;
  String consultationId;
  String question;
  String reponse;
  String consultationHistoireMaladieStatus;
  String dateEnregistrement;

  HistoireMaladie(
      {this.consultationHistoireMaladieId,
        this.consultationId,
        this.question,
        this.reponse,
        this.consultationHistoireMaladieStatus,
        this.dateEnregistrement});

  HistoireMaladie.fromJson(Map<String, dynamic> json) {
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

  String getIndex(int index) {
    switch (index) {
      case 0:
        return question.toLowerCase();
      case 1:
        return reponse.toLowerCase();
    }
    return '';
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

  String getIndex(int index) {
    switch (index) {
      case 0:
        return donneeLabel.toLowerCase();
      case 1:
        return donneeValeur.toLowerCase();
    }
    return '';
  }
}

class ExamensLaboratoire {
  String examenLaboratoireId;
  String examen;
  String resultat;
  String consultationId;
  String dateEnregistrement;

  ExamensLaboratoire(
      {this.examenLaboratoireId,
        this.examen,
        this.resultat,
        this.consultationId,
        this.dateEnregistrement});

  ExamensLaboratoire.fromJson(Map<String, dynamic> json) {
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

  String getIndex(int index) {
    switch (index) {
      case 0:
        return examen.toLowerCase();
      case 1:
        return resultat.toLowerCase();
    }
    return '';
  }
}

class Prescriptions {
  String prescriptionId;
  String consultationId;
  String prescription;
  String dosage;
  String prescriptionStatus;
  String dateEnregistrement;

  Prescriptions(
      {this.prescriptionId,
        this.consultationId,
        this.prescription,
        this.dosage,
        this.prescriptionStatus,
        this.dateEnregistrement});

  Prescriptions.fromJson(Map<String, dynamic> json) {
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

  String getIndex(int index) {
    switch (index) {
      case 0:
        return prescription.toLowerCase();
      case 1:
        return dosage.toLowerCase();
    }
    return '';
  }
}
