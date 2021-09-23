import 'dart:convert';
import 'dart:io';

import 'package:android_multiple_identifier/android_multiple_identifier.dart';
import 'package:http/http.dart' as Api;
import 'package:medpad/helpers/data_storage.dart';
import 'package:medpad/models/consult_antecedent_model.dart';
import 'package:medpad/models/consult_examen_model.dart';
import 'package:medpad/models/consult_prescription_model.dart';
import 'package:medpad/models/consult_waiting_model.dart';
import 'package:medpad/models/consultaion_model.dart';
import 'package:medpad/models/examen_encours_model.dart';
import 'package:medpad/models/finger_model.dart';
import 'package:medpad/models/hospital_bed_model.dart';
import 'package:medpad/models/hospitalisations_model.dart';
import 'package:medpad/models/patient_doc_model.dart';
import 'package:medpad/models/signe_vitaux_model.dart';
import 'package:medpad/models/story_maladies_model.dart';
import 'package:medpad/models/fiche_labo_model.dart';

class ApiManagerService {
  static final String baseURL = "http://medpad.rtgroup-rdc.com";

  static Future createHospitalAccount(
      {nom, tel, province, ville, adresse, pwd, email}) async {
    final response = await Api.post(
        Uri.parse("${ApiManagerService.baseURL}/hopitals/compte/register"),
        body: jsonEncode(<String, dynamic>{
          "nom": nom,
          "telephone": tel,
          "province": province,
          "ville": ville,
          "adresse": adresse,
          "email": email,
          "pass": pwd
        }));
    print(response.body);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var status = jsonResponse["reponse"]["status"];

      if (status == "success" && status != null) {
        var hName = jsonResponse["reponse"]["data"]["nom"];
        var hId = jsonResponse["reponse"]["data"]["hopital_id"];
        storage.write("hospital_name", hName);
        storage.write("hospital_id", hId);
        return jsonResponse;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future loginHospital({email, pwd}) async {
    final response = await Api.post(
        Uri.parse("${ApiManagerService.baseURL}/hopitals/compte/login"),
        body: jsonEncode(<String, dynamic>{"email": email, "pass": pwd}));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var status = jsonResponse["reponse"]["status"];
      print(jsonResponse);
      if (status == "success" && status != "failed") {
        var hName = jsonResponse["reponse"]["data"]["nom"];
        var hId = jsonResponse["reponse"]["data"]["hopital_id"];
        storage.write("hospital_name", hName);
        storage.write("hospital_id", hId);
        storage.write("isLoggedIn", true);
        return jsonResponse;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<ConsultationsWaitingView> consultationWatingView() async {
    var hospitalId = storage.read("hospital_id");

    final response = await Api.post(
        Uri.parse("${ApiManagerService.baseURL}/hopitals/consultations/voir"),
        body: jsonEncode(<String, dynamic>{
          "hopital_id": hospitalId,
        }));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return ConsultationsWaitingView.fromJson(jsonResponse);
    } else {
      return null;
    }
  }
  //Consult phase

  static Future hospitaliser({litId, consultId}) async {
    var hospitalId = storage.read("hospital_id");

    final response = await Api.post(
        Uri.parse(
            "${ApiManagerService.baseURL}/hopitals/hospitalisations/hospitaliser"),
        body: jsonEncode(<String, dynamic>{
          "hopital_id": hospitalId,
          "lit_id": litId,
          "consultation_id": consultId
        }));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var status = jsonResponse["reponse"]["status"];
      if (status == "success" && status != null) {
        return status;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future doctorRegister(
      {nom,
      sexe,
      nais,
      specialite,
      email,
      tel,
      province,
      ville,
      adresse,
      empreinte1,
      empreinte2,
      empreinte3}) async {
    var hospitalId = storage.read("hospital_id");

    final response = await Api.post(
        Uri.parse("${ApiManagerService.baseURL}/hopitals/medecins/enregistrer"),
        body: jsonEncode(<String, dynamic>{
          "hopital_id": hospitalId,
          "nom": nom,
          "sexe": sexe,
          "date_naissance": nais,
          "specialites": specialite,
          "telephone": tel,
          "province": province,
          "ville": ville,
          "adresse": adresse,
          "email": email,
          "empreinte_1": empreinte1,
          "empreinte_2": empreinte2,
          "empreinte_3": empreinte3,
        }));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var status = jsonResponse["reponse"]["status"];
      if (status == "success" && status != null) {
        return jsonResponse;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future infirmerRegister(
      {nom, sexe, nais, email, tel, province, ville, adresse}) async {
    var hospitalId = storage.read("hospital_id");

    final response = await Api.post(
        Uri.parse(
            "${ApiManagerService.baseURL}/hopitals/infirmiers/enregistrer"),
        body: jsonEncode(<String, dynamic>{
          "hopital_id": hospitalId,
          "nom": nom,
          "sexe": sexe,
          "date_naissance": nais,
          "email": email,
          "telephone": tel,
          "province": province,
          "ville": ville,
          "adresse": adresse
        }));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var status = jsonResponse["reponse"]["status"];
      if (status == "success" && status != null) {
        return jsonResponse;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future patientPriseContact({plainte, patientId}) async {
    var hospitalId = storage.read("hospital_id");

    final response = await Api.post(
        Uri.parse(
            "${ApiManagerService.baseURL}/hopitals/consultations/prisedecontact"),
        body: jsonEncode(<String, dynamic>{
          "hopital_id": hospitalId,
          "plainte": plainte,
          "patient_id": patientId
        }));
    print(response.body);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var status = jsonResponse["reponse"]["status"];
      if (status == "success" && status != null) {
        return jsonResponse;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future savePatient({
    nom,
    sexe,
    nais,
    profession,
    tel,
    email,
    province,
    ville,
    adresse,
    empreinte1,
    empreinte2,
    empreinte3,
  }) async {
    var hospitalId = storage.read("hospital_id");
    final response = await Api.post(
        Uri.parse("${ApiManagerService.baseURL}/hopitals/patients/enregistrer"),
        body: jsonEncode(<String, dynamic>{
          "hopital_id": hospitalId,
          "nom": nom,
          "sexe": sexe,
          "date_naissance": nais,
          "profession": profession,
          "telephone": tel,
          "email": email,
          "province": province,
          "ville": ville,
          "adresse": adresse,
          "empreinte_1": empreinte1,
          "empreinte_2": empreinte2,
          "empreinte_3": empreinte3,
        }));
    print(response.body);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var status = jsonResponse["reponse"]["status"];
      var patientId = jsonResponse["reponse"]["patient_id"];
      storage.write("patient_id", patientId);
      if (status == "success" && status != null) {
        return jsonResponse;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<ConsultationModel> consultationSigneVitaux(
      {consultationId, signeVitalId, signeVitalValue}) async {
    var hospitalId = storage.read("hospital_id");

    final response = await Api.post(
        Uri.parse(
            "${ApiManagerService.baseURL}/hopitals/consultations/signesvitaux"),
        body: jsonEncode(<String, dynamic>{
          "hopital_id": hospitalId,
          "consultation_id": consultationId,
          "signe_vital_id": signeVitalId,
          "signe_vital_valeur": signeVitalValue
        }));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return ConsultationModel.fromJson(jsonResponse);
    } else {
      return null;
    }
  }

  static Future<StoryMaladiesModel> consultationHistoireMaladie(
      {consultId, question, reponse}) async {
    var hospitalId = storage.read("hospital_id");
    final response = await Api.post(
        Uri.parse(
            "${ApiManagerService.baseURL}/hopitals/consultations/histoiremaladie"),
        body: jsonEncode(<String, dynamic>{
          "hopital_id": hospitalId,
          "consultation_id": consultId,
          "question": question,
          "reponse": reponse
        }));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      return StoryMaladiesModel.fromJson(jsonResponse);
    } else {
      return null;
    }
  }

  static Future<ConsultationAntecedentModel> consultationAntecedents(
      {consultId, antecedentType, question, reponse}) async {
    var hospitalId = storage.read("hospital_id");
    final response = await Api.post(
        Uri.parse(
            "${ApiManagerService.baseURL}/hopitals/consultations/antecedents"),
        body: jsonEncode(<String, dynamic>{
          "hopital_id": hospitalId,
          "consultation_id": consultId,
          "antecedent_type": antecedentType,
          "question": question,
          "reponse": reponse
        }));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return ConsultationAntecedentModel.fromJson(jsonResponse);
    } else {
      return null;
    }
  }

  static Future<ConsultationExamenPhysiqueModel> consultationExamenPhysique(
      {consultationId, dataLabel, dataValue}) async {
    var hospitalId = storage.read("hospital_id");
    final response = await Api.post(
        Uri.parse(
            "${ApiManagerService.baseURL}/hopitals/consultations/examensphysique"),
        body: jsonEncode(<String, dynamic>{
          "hopital_id": hospitalId,
          "consultation_id": consultationId,
          "donnee_label": dataLabel,
          "donnee_valeur": dataValue
        }));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return ConsultationExamenPhysiqueModel.fromJson(jsonResponse);
    } else {
      return null;
    }
  }

  static Future<ConsultationPrescriptionModel> consultationPrescription(
      {consultId, prescription, dosage}) async {
    var hospitalId = storage.read("hospital_id");

    final response = await Api.post(
        Uri.parse(
            "${ApiManagerService.baseURL}/hopitals/consultations/prescription"),
        body: jsonEncode(<String, dynamic>{
          "hopital_id": hospitalId,
          "consultation_id": consultId,
          "prescription": prescription,
          "dosage": dosage
        }));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return ConsultationPrescriptionModel.fromJson(jsonResponse);
    } else {
      return null;
    }
  }

  static Future voirFiche() async {
    var hospitalId = storage.read("hospital_id");

    final response = await Api.post(
        Uri.parse(
            "${ApiManagerService.baseURL}/hopitals/laboratoire/fiche/voir"),
        body: jsonEncode(<String, dynamic>{"hopital_id": hospitalId}));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var status = jsonResponse["reponse"]["status"];
      if (status == "success" && status != null) {
        return jsonResponse;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<SigneVitauxModel> voirSigneVitaux() async {
    var hospitalId = storage.read("hospital_id");

    final response = await Api.post(
        Uri.parse("${ApiManagerService.baseURL}/hopitals/signesvitaux/voir"),
        body: jsonEncode(<String, dynamic>{"hopital_id": hospitalId}));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return SigneVitauxModel.fromJson(jsonResponse);
    } else {
      return null;
    }
  }

  static Future<LaboFicheModel> voirExamens() async {
    var hospitalId = storage.read("hospital_id");
    final response = await Api.post(
        Uri.parse(
            "${ApiManagerService.baseURL}/hopitals/laboratoire/fiche/voir"),
        body: jsonEncode(<String, dynamic>{"hopital_id": hospitalId}));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return LaboFicheModel.fromJson(jsonResponse);
    } else {
      return null;
    }
  }

  static Future createSigneVitaux({titre}) async {
    var hospitalId = storage.read("hospital_id");

    final response = await Api.post(
        Uri.parse("${ApiManagerService.baseURL}/hopitals/signesvitaux/ajouter"),
        body: jsonEncode(
            <String, dynamic>{"hopital_id": hospitalId, "titre": titre}));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var status = jsonResponse["reponse"]["status"];
      if (status == "success" && status != null) {
        return jsonResponse;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  //////////////////////***********Labo********/////////////////////

  static Future sendExamenLabo({consultId, ficheLaboId}) async {
    var hospitalId = storage.read("hospital_id");
    final response = await Api.post(
        Uri.parse(
            "${ApiManagerService.baseURL}/hopitals/consultations/examens"),
        body: jsonEncode(<String, dynamic>{
          "hopital_id": hospitalId,
          "consultation_id": consultId,
          "fiche_laboratoire_id": ficheLaboId
        }));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var status = jsonResponse["reponse"]["status"];
      if (status == "success" && status != null) {
        return jsonResponse;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<ExamensEnCoursModel> waitExamenLabo({consultId}) async {
    var hospitalId = storage.read("hospital_id");
    Api.Response response;

    if (consultId == null || consultId == "") {
      response = await Api.post(
          Uri.parse(
              "${ApiManagerService.baseURL}/hopitals/laboratoire/examens/encours"),
          body: jsonEncode(<String, dynamic>{"hopital_id": hospitalId}));
    } else {
      response = await Api.post(
          Uri.parse(
              "${ApiManagerService.baseURL}/hopitals/laboratoire/examens/encours"),
          body: jsonEncode(<String, dynamic>{
            "hopital_id": hospitalId,
            "consultation_id": consultId
          }));
    }

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return ExamensEnCoursModel.fromJson(jsonResponse);
    } else {
      return null;
    }
  }

  static Future saveResultExamen({examenId, result}) async {
    var hospitalId = storage.read("hospital_id");
    final response = await Api.post(
        Uri.parse(
            "${ApiManagerService.baseURL}/hopitals/laboratoire/examens/resultat"),
        body: jsonEncode(<String, dynamic>{
          "hopital_id": hospitalId,
          "examen_laboratoire_id": examenId,
          "resultat": result
        }));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      return null;
    }
  }

  static Future createExamen({examen}) async {
    var hospitalId = storage.read("hospital_id");

    final response = await Api.post(
        Uri.parse("${ApiManagerService.baseURL}/hopitals/laboratoire/fiche"),
        body: jsonEncode(
            <String, dynamic>{"hopital_id": hospitalId, "examen": examen}));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var status = jsonResponse["reponse"]["status"];
      if (status == "success" && status != null) {
        return jsonResponse;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  //////////////////////////******Finger*****///////////////////////////////////
  static Future<FingersModel> getAllFinger({type}) async {
    var hospitalId = storage.read("hospital_id");
    final response = await Api.post(
        Uri.parse("${ApiManagerService.baseURL}/hopitals/empreintes/get"),
        body: jsonEncode(
            <String, dynamic>{"hopital_id": hospitalId, "type": type}));
    var jsonResponse = jsonDecode(response.body);
    return FingersModel.fromJson(jsonResponse);
  }

  static Future<PatientDocModel> getPatientDoc({fingerId}) async {
    var hospitalId = storage.read("hospital_id");

    final response = await Api.post(
        Uri.parse(
            "${ApiManagerService.baseURL}/hopitals/patients/dossiermedical"),
        body: jsonEncode(<String, dynamic>{
          "hopital_id": hospitalId,
          "empreinte_id": fingerId
        }));
    var jsonResponse = jsonDecode(response.body);
    return PatientDocModel.fromJson(jsonResponse);
  }

  ///////////////////////////////////Hospital manager//////////////////////////////

  static Future addHospitalBed({String design}) async {
    var hospitalId = storage.read("hospital_id");

    final response = await Api.post(
        Uri.parse("${ApiManagerService.baseURL}/hopitals/lits/ajouter"),
        body: jsonEncode(<String, dynamic>{
          "hopital_id": hospitalId,
          "designation": design
        }));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var status = jsonResponse["reponse"]["status"];
      if (status == "success" && status != null) {
        return status;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<HospitalBedModel> allBedsView() async {
    var hospitalId = storage.read("hospital_id");

    final response = await Api.post(
        Uri.parse("${ApiManagerService.baseURL}/hopitals/lits/all"),
        body: jsonEncode(<String, dynamic>{
          "hopital_id": hospitalId,
        }));
    var jsonResponse = jsonDecode(response.body);
    return HospitalBedModel.fromJson(jsonResponse);
  }

  /////////////////////////////////***Hospitalisation****//////////////////////////
  //Hospitalisation traitements admission
  static Future hospitalisationTraitment({hospitalizationId, prescId}) async {
    try {
      var hospitalId = storage.read("hospital_id");

      final response = await Api.post(
          Uri.parse(
              "${ApiManagerService.baseURL}/hopitals/hospitalisations/traitements"),
          body: jsonEncode(<String, dynamic>{
            "hopital_id": hospitalId,
            "hospitalisation_id": hospitalizationId,
            "prescription_id": prescId
          }));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var status = jsonData["reponse"]["status"];
        if (status.toString() == "success") {
          var data = jsonData["reponse"]["traitements"];
          return data;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  //Hospitalisation signes vitaux
  static Future hospitalisationSignesVitaux(
      {hospitalizationId, signeVitalId, value}) async {
    try {
      var hospitalId = storage.read("hospital_id");
      final response = await Api.post(
          Uri.parse(
              "${ApiManagerService.baseURL}/hopitals/hospitalisations/signesvitaux"),
          body: jsonEncode(<String, dynamic>{
            "hopital_id": hospitalId,
            "hospitalisation_id": hospitalizationId,
            "signe_vital_id": signeVitalId,
            "signe_vital_valeur": value
          }));

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["reponse"]["status"].toString() == "success") {
          var data = jsonResponse["reponse"]["signes_vitaux"];
          return data;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  //Hospitalisation observations
  static Future hospitalisationObs({hospitalizationId, obs}) async {
    try {
      var hospitalId = storage.read("hospital_id");

      final response = await Api.post(
          Uri.parse(
              "${ApiManagerService.baseURL}/hopitals/hospitalisations/observations"),
          body: jsonEncode(<String, dynamic>{
            "hopital_id": hospitalId,
            "hospitalisation_id": hospitalizationId,
            "observation": obs
          }));

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var status = jsonResponse["reponse"]["status"];
        if (status.toString() == "success") {
          var data = jsonResponse["reponse"]["observations"];
          return data;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  //Hospitalisation Actes
  static Future hospitalisationActes({hospitalizationId, acte}) async {
    try {
      var hospitalId = storage.read("hospital_id");

      final response = await Api.post(
          Uri.parse(
              "${ApiManagerService.baseURL}/hopitals/hospitalisations/notes"),
          body: jsonEncode(<String, dynamic>{
            "hopital_id": hospitalId,
            "hospitalisation_id": hospitalizationId,
            "acte": acte
          }));

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var status = jsonResponse["reponse"]["status"];
        if (status.toString() == "success") {
          var data = jsonResponse["reponse"]["actes"];
          return data;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  //Hospitalisations view
  static Future<HospitalisationsModel> hospitalisationsView() async {
    try {
      var hospitalId = storage.read("hospital_id");

      final response = await Api.post(
          Uri.parse(
              "${ApiManagerService.baseURL}/hopitals/hospitalisations/voir"),
          body: jsonEncode(<String, dynamic>{"hopital_id": hospitalId}));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        return HospitalisationsModel.fromJson(jsonData);
      }
    } catch (err) {
      print("error from $err");
    }
  }

  //////////////////////////**admission premier soins**///////////////////////////

  static Future premiersoins({String traitement, String dosage}) async {
    var hospitalId = storage.read("hospital_id");
    var patientId = storage.read("patient_id");

    final response = await Api.post(
        Uri.parse("${ApiManagerService.baseURL}/hopitals/premiersoins"),
        body: jsonEncode(<String, dynamic>{
          "hopital_id": hospitalId,
          "patient_id": patientId,
          "traitement": traitement,
          "dosage": dosage
        }));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var status = jsonResponse["reponse"]["status"];
      if (status == "success" && status != null) {
        return status;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  //Devices authenticate
  static Future<void> checkDevice() async {
    try {
      String imei = await AndroidMultipleIdentifier.imeiCode;
      print("imei: $imei");
      final response = await Api.post(
          Uri.parse("${ApiManagerService.baseURL}/devices/usages/authentifier"),
          body: jsonEncode(<String, dynamic>{
            "imei": imei,
          }));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var json = jsonResponse["authentification"];
        if (json["status"] == "success" && json["status"] != null) {
          print(json["status"]);
          storage.write("device_id", json["device_id"]);
        } else {
          exit(0);
        }
      } else {
        exit(0);
      }
    } catch (err) {
      exit(0);
    }
  }

  //register device
  static Future regDevice() async {
    var hospitalId = storage.read("hospital_id");
    var deviceId = storage.read("device_id");
    final response = await Api.post(
        Uri.parse("${ApiManagerService.baseURL}/devices/usages/enregistrer"),
        body: jsonEncode(<String, dynamic>{
          "device_id": deviceId,
          "hopital_id": hospitalId,
        }));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var status = jsonResponse["reponse"]["status"];
      if (status == "success" && status != null) {
        print(status);
      } else {
        print("failed");
      }
    } else {
      return null;
    }
  }

  //Check version of app for updating
  static Future checkAppVersion({int versionCode}) async {
    var deviceId = storage.read("device_id");
    final response = await Api.post(
        Uri.parse("${ApiManagerService.baseURL}/devices/updates/app"),
        body: jsonEncode(<String, dynamic>{
          "device_id": deviceId,
          "version_code": versionCode
        }));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var status = jsonResponse["update"]["status"];
      if (status != null) {
        return jsonResponse;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
