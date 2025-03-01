import 'package:blt/src/components/contributor_card.dart';
import 'package:blt/src/constants/about_constants.dart';
import 'package:blt/src/util/api/general_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

/// Page for describing the BLT project.
class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("About Us"),
        backgroundColor: Color(0xFFDC4654),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 36, 0, 24),
              child: SvgPicture.asset(
                'assets/blt_logo.svg',
                width: 169.42,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 24),
              child: Text(
                aboutBLT,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: Color(0xFF737373),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
              alignment: Alignment.centerLeft,
              child: Text(
                "What's in it for you?",
                style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                    color: Color(0xFFDC4654),
                    fontSize: 20,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Text(
                forYou,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: Color(0xFF737373),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
              alignment: Alignment.centerLeft,
              child: Text(
                "How it works?",
                style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                    color: Color(0xFFDC4654),
                    fontSize: 17.5,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
              alignment: Alignment.centerLeft,
              child: Text(
                "For Testers",
                style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                    color: Color(0xFF737373),
                    fontSize: 15,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Text(
                forTesters,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: Color(0xFF737373),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
              alignment: Alignment.centerLeft,
              child: Text(
                "For Organizations",
                style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                    color: Color(0xFF737373),
                    fontSize: 15,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 24),
              child: Text(
                forOrgs,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: Color(0xFF737373),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 32),
              alignment: Alignment.centerLeft,
              child: Text(
                "Contributors",
                style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                    color: Color(0xFFDC4654),
                    fontSize: 20,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FutureBuilder(
              future: GeneralApiClient.getContributors(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Map<String, String>>> snapshot) {
                if (snapshot.hasData) {
                  List<Widget> contributors = [];
                  for (var contributor in snapshot.data!) {
                    contributors.add(InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            new PageRouteBuilder(
                                opaque: false,
                                barrierDismissible:true,
                                pageBuilder: (BuildContext context, _, __) {
                                  return ContributorCard(contributor: contributor);
                                }
                            )
                        );
                      },
                      child: Ink(
                        child: Column(
                          children: [
                            Hero(
                              tag: "image${contributor["id"]}",
                              child: CircleAvatar(
                                radius: 32,
                                backgroundImage: CachedNetworkImageProvider(contributor["img"]!),
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Hero(
                              tag: "name${contributor["id"]}",
                              child: Material(
                                color: Colors.transparent,
                                child: Text(
                                  contributor["name"]!.replaceAll(" ", "\n"),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                      color: Color(0xFF737373),
                                    ),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
                  }
                  return Wrap(
                    runSpacing: 32.0,
                    spacing: 32.0,
                    alignment: WrapAlignment.spaceEvenly,
                    children: contributors,
                  );
                } else {
                  return Container();
                }
              },
            ),
            SizedBox(
              height: 48.0,
            ),
          ],
        ),
      ),
    );
  }
}
