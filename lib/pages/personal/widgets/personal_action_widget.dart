import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medpad/pages/personal/pages/infirmier_create_page.dart';
import 'package:medpad/pages/personal/pages/medecin_create_page.dart';
import 'package:medpad/widgets/action_card_widget.dart';

class PersonalActionGrid extends StatelessWidget {
  final double crossAxisAccount;
  final double childAspectRatio;

  const PersonalActionGrid(
      {Key key, this.crossAxisAccount, this.childAspectRatio})
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
          title: "Création Médecin",
          icon: CupertinoIcons.person_badge_plus_fill,
          navigate: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MedecinCreatePage()));
          },
        ),
        ActionCard(
          title: "Création infirmier",
          icon: CupertinoIcons.person_add,
          navigate: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => InfirmierCreatePage()));
          },
        ),
        ActionCard(
          title: "Assignation patient",
          icon: Icons.assignment_returned_sharp,
          navigate: () {},
        ),
        ActionCard(
          title: "Création personnel connexes",
          icon: CupertinoIcons.person_3,
          navigate: () {},
        ),
      ],
    );
  }
}
