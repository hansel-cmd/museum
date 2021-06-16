import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:museum/pages/authentication.dart';
import 'package:museum/services/database_connection.dart';
import 'package:museum/utils/constants.dart';
import 'package:museum/utils/helper.dart';

class DrawerScreen extends StatelessWidget {
  final user;
  DrawerScreen({this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Constants.primaryColor,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: Container(
                    margin: EdgeInsets.fromLTRB(25, 0, 10, 10),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: CircleAvatar(
                            backgroundImage: user.photoURL != null
                                ? NetworkImage(user.photoURL)
                                : AssetImage("assets/images/050-fox.png"),
                            radius: 40.0,
                          ),
                        ),
                        Text(
                            user.displayName != null
                                ? "${user.displayName}"
                                : "Anonymous",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            )),
                        Text(
                          "${user.email}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Material(
                    color: Colors.transparent,
                    child: ListView(
                      children: [
                        links(
                          name: "Lorem Link",
                          icon: Icon(Icons.library_books_outlined),
                          myFunc: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        links(
                          name: "Ipsum Link",
                          icon: Icon(Icons.home),
                          myFunc: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        links(
                          name: "Dolor Link",
                          icon: Icon(Icons.person),
                          myFunc: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        links(
                          name: "Sit Link",
                          icon: Icon(Icons.panorama_outlined),
                          myFunc: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        logoutLink(context),
                        Container(
                          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Constants.blackColor, width: 1.5)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                color: Colors.white,
                // flex: 0,
                child: Text(
                  "Hansel Crackers, Inc.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Constants.blackColor,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget logoutLink(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: InkWell(
          onTap: () async {
            await signOut();
            Helper.nextScreenWithoutPrevious(context, Authentication());
          },
          splashColor: Constants.whiteDarker,
          highlightColor: Constants.whiteDarker,
          child: Container(
              padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.logout),
                  SizedBox(width: 10),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Logout",
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  )
                ],
              ))),
    );
  }

  Widget links({String name, Icon icon, Function myFunc}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: InkWell(
        onTap: myFunc,
        splashColor: Constants.whiteDarker,
        highlightColor: Constants.whiteDarker,
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              icon,
              SizedBox(width: 10),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text("$name",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w500)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
