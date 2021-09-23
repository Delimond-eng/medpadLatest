import 'package:get/get.dart';
import 'package:medpad/helpers/data_storage.dart';
import 'package:medpad/models/consult_antecedent_model.dart';
import 'package:medpad/models/consult_examen_model.dart';
import 'package:medpad/models/consult_prescription_model.dart';
import 'package:medpad/models/consult_waiting_model.dart';
import 'package:medpad/models/consultaion_model.dart';
import 'package:medpad/models/examen_encours_model.dart';
import 'package:medpad/models/fiche_labo_model.dart';
import 'package:medpad/models/finger_model.dart';
import 'package:medpad/models/hospital_bed_model.dart';
import 'package:medpad/models/signe_vitaux_model.dart';
import 'package:medpad/models/story_maladies_model.dart';
import 'package:medpad/services/api_manager_service.dart';

class ApiController extends GetxController {
  static ApiController instance = Get.find();

  var selected = "".obs;
  // ignore: deprecated_member_use
  var signVitauxList = List<SignesVitaux>().obs;
  // ignore: deprecated_member_use
  var consultationList = List<ConsultationSignesVitaux>().obs;

  // ignore: deprecated_member_use
  var consultStoryList = List<Data>().obs;

  // ignore: deprecated_member_use
  var consultAntecedentList = List<Antecedents>().obs;
  // ignore: deprecated_member_use
  var consultExamensList = List<ExamensPhysique>().obs;
  // ignore: deprecated_member_use
  var consultPrescriptionsList = List<Prescriptions>().obs;
  // ignore: deprecated_member_use
  var examenFicheList = List<Fiche>().obs;
  // ignore: deprecated_member_use
  var examenEcoursList = List<Examens>().obs;
  // ignore: deprecated_member_use
  var consultationWaitingList = List<Consultations>().obs;
  // ignore: deprecated_member_use
  var fingerList = List<Empreintes>().obs;
  // ignore: deprecated_member_use
  var hospitalBedsList = List<Lits>().obs;
  //consultations vars
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    try {
      await ApiManagerService.voirSigneVitaux().then((res) {
        if (res != null) {
          signVitauxList.value = res.signesVitaux;
        }
      });

      await ApiManagerService.voirExamens().then((result) {
        examenFicheList.value = result.fiche;
      });

      await ApiManagerService.waitExamenLabo().then((result) {
        examenEcoursList.value = result.examensData[0].examens;
      });

      await ApiManagerService.consultationWatingView().then((result) {
        consultationWaitingList.value = result.consultations;
      });

      await ApiManagerService.allBedsView().then((result) {
        hospitalBedsList.value = result.lits;
      });
    } catch (err) {
      print(err);
    }
  }

  Future<void> cleanData() async {
    storage.remove("consult_id");
    storage.remove("patient_id");
    consultationList.value = [];
    consultAntecedentList.value = [];
    consultExamensList.value = [];
    examenEcoursList.value = [];
    consultStoryList.value = [];
    consultPrescriptionsList.value = [];
  }

  Future<void> viewExamenEnCours({consultId}) async {
    try {
      await ApiManagerService.waitExamenLabo(consultId: "$consultId")
          .then((result) {
        examenEcoursList.value = result.examensData[0].examens;
      });
    } catch (err) {
      print(err);
    }
  }

  Future<void> loadFingers({String type}) async {
    try {
      await ApiManagerService.getAllFinger(type: type).then((result) {
        fingerList.value = result.empreintes;
      });
    } catch (err) {
      print(err);
    }
  }
}
