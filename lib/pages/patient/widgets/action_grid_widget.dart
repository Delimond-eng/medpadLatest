import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medpad/constants/controllers.dart';
import 'package:medpad/pages/patient/pages/patient_consultations_page.dart';
import 'package:medpad/widgets/action_card_widget.dart';

class ActionGridWidget extends StatelessWidget {
  final double crossAxisAccount;
  final double childAspectRatio;
  final GlobalKey<NavigatorState> navigationKey = GlobalKey();

  final textSignValue = TextEditingController();
  final textExamenNom = TextEditingController();

  ActionGridWidget({Key key, this.crossAxisAccount, this.childAspectRatio})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 4 ?? crossAxisAccount,
      crossAxisSpacing: 40,
      childAspectRatio: 1.4 ?? childAspectRatio,
      children: [
        ActionCard(
          title: "Consultation",
          icon: Icons.medication,
          navigate: () {
            navigationController.rootingTo(PatientConsultationsPage());
          },
        ),
        ActionCard(
          title: "Autres...",
          icon: CupertinoIcons.asterisk_circle_fill,
          navigate: () {},
        ),
        ActionCard(
          title: "Traitements",
          icon: Icons.local_pharmacy_rounded,
          navigate: () {},
        ),
        ActionCard(
          title: "Autres...",
          icon: Icons.manage_accounts_rounded,
          navigate: () {},
        ),
      ],
    );
  }
}

/*Container(
  height: 40,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(5)
    ),
  child: DropdownButton<String>(
    underline: SizedBox(),
    value: selectedDropDownValue,
    hint: Text("Sélectionnez", style: GoogleFonts.mulish(color: Colors.grey[400]),),
    isExpanded: true,
    items: items.map((e) {
      return DropdownMenuItem<String>(
          value: e, child: Text("$e"));
    }).toList(),
    onChanged: (value) {
      setState(() {
        selectedDropDownValue = value;
        print(selectedDropDownValue);
      });
    },
  ),
),*/
