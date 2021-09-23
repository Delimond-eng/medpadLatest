
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpad/constants/style.dart';

class SignCard extends StatelessWidget {
  final String title;
  final String value;

  SignCard({Key key, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: 300.0,
      child: Card(
        color: Colors.blue[100],
        elevation: 5,
        shadowColor: Colors.black12,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0))
              ),
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Signe vital",
                    style: GoogleFonts.mulish(
                        color: Colors.blue[800],
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    title.toLowerCase(),
                    style: GoogleFonts.mulish( fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      height: 4,
                      decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Valeur",
                    style: GoogleFonts.mulish(
                        color: Colors.blue[800],
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    value.toLowerCase(),
                    style: GoogleFonts.mulish(
                         fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
