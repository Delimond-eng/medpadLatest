import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/helpers/utilities.dart';
import 'package:medpad/pages/labo/pages/examen_en_cour_page.dart';
import 'package:medpad/pages/labo/wigdets/actions.dart';
import 'package:medpad/pages/patient/pages/patient_premier_soins_page.dart';
import 'package:medpad/widgets/action_card_widget.dart';

class LaboActionCard extends StatelessWidget {
  final double crossAxisAccount;
  final double childAspectRatio;

  const LaboActionCard({Key key, this.crossAxisAccount, this.childAspectRatio})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 4 ?? crossAxisAccount,
      crossAxisSpacing: 40.0,
      childAspectRatio: 1.4 ?? childAspectRatio,
      children: [
        ActionCard(
          title: "Configuration\nsigne vitaux",
          icon: Icons.accessibility,
          navigate: () {
            configSignesVitaux(context: context);
          },
        ),
        ActionCard(
          title: "Configuration types\nexamens médicaux",
          icon: CupertinoIcons.lab_flask,
          navigate: () {
            configExamens(context: context);
          },
        ),
        ActionCard(
          title: "Voir Examens en cours",
          icon: CupertinoIcons.lab_flask_solid,
          navigate: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ExamenEnCoursPage()));
          },
        ),
        ActionCard(
          title: "Autres...",
          icon: Icons.medication_rounded,
          navigate: () {
            menuController.activeItem.value = "Premiers soins";
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientPremierSoinPage()));
          },
        ),
      ],
    );
  }
}
