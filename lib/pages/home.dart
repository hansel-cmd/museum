import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:museum/models/property.dart';
import 'package:museum/pages/filters.dart';
import 'package:museum/services/api_connection.dart';
import 'package:museum/utils/constants.dart';
import 'package:museum/utils/helper.dart';
import 'package:museum/widgets/drawer.dart';
import 'package:museum/widgets/loading.dart';
import 'package:museum/widgets/art_card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with Api {
  final user = FirebaseAuth.instance.currentUser;
  bool isLoading = true;
  bool noDisplay = false;
  bool isLoadingForCards = true;
  Map collectionObjectId = {};
  List arts = [];
  Map departmentObject = {};
  int counter = 0;
  bool isMax = false;

  initState() {
    getAllCollections();
    super.initState();
  }

  getAllCollections() async {
    var res = await getAllCollectionObjectID();
    if (res.isEmpty) {
      setState(() {
        isLoading = false;
        noDisplay = true;
      });
      return;
    }
    collectionObjectId = res;
    collectionObjectId["objectIDs"].shuffle();

    print("next phase na ko");

    int i;
    for (i = 1; i < 30 && i < collectionObjectId["total"]; i++) {
      getObjectInfo(id: collectionObjectId["objectIDs"][i]).then((value) {
        setState(() {
          arts.add(value);
          isLoadingForCards = false;
        });
      });
    }

    getAllDepartment().then((value) {
      print("value is: ");
      setState(() {
        departmentObject = value;
      });
      print(departmentObject);
      return value;
    });

    setState(() {
      counter = i;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("MMAC"),
            ),
            endDrawer: DrawerScreen(user: user),
            body: LoaderOverlay(
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Art Highlights from\n",
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      height: 1.3,
                                      color: Color.fromRGBO(22, 27, 40, 70),
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Renaissance period",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w800,
                                      color: Constants.blackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: departmentObject.isEmpty ? null : () {
                              Helper.nextScreen(context,
                                  Filters(departmentObject: departmentObject));
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.resolveWith(
                                  (states) =>
                                      EdgeInsets.fromLTRB(10, 10, 10, 10)),
                              shape: MaterialStateProperty.resolveWith(
                                (state) => RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Constants.primaryColor),
                              foregroundColor: MaterialStateColor.resolveWith(
                                  (states) => Constants.primaryColor),
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => Constants.primaryColor),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  FlutterIcons.ios_options_ion,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "Filters",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      isLoadingForCards
                          ? Expanded(
                              child: Center(
                                child: SpinKitRing(
                  size: 40, color: Constants.primaryColor),
                              ),
                            )
                          : noDisplay
                              ? Expanded(
                                  child: Center(
                                    child: Text(
                                      "Nothing to display as of the moment.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        height: 1.3,
                                        color: Color.fromRGBO(22, 27, 40, 70),
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: ListView(
                                    children: [
                                      ListView.separated(
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return SizedBox(
                                            height: 15.0,
                                          );
                                        },
                                        itemCount: arts.length,
                                        physics: ScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          Property prop = Property(
                                              title: arts[index]["title"],
                                              objectName: arts[index]
                                                  ["objectName"],
                                              department: arts[index]
                                                  ["department"],
                                              accessionYear: arts[index]
                                                  ["accessionYear"],
                                              city: arts[index]["city"],
                                              country: arts[index]["country"],
                                              primaryImage: arts[index]
                                                  ["primaryImage"],
                                              primaryImageSmall: arts[index]
                                                  ["primaryImageSmall"],
                                              additionalImages: arts[index]
                                                  ["additionalImages"],
                                              isPublicDomain: arts[index]
                                                  ["isPublicDomain"],
                                              isHighlight: arts[index]
                                                  ["isHighlight"]);

                                          return ArtCard(
                                            property: prop,
                                          );
                                        },
                                      ),
                                      !isMax
                                          ? arts.length != 0
                                              ? TextButton(
                                                  onPressed: fetch,
                                                  child: Text(
                                                    "Load More...",
                                                    style: TextStyle(
                                                      letterSpacing: 1.2,
                                                    ),
                                                  ))
                                              : Container()
                                          : Container(),
                                    ],
                                  ),
                                )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  void fetch() async {
    context.loaderOverlay.show();

    int i;
    for (i = counter;
        i < (counter + 5) && i < collectionObjectId["total"];
        i++) {
      getObjectInfo(id: collectionObjectId["objectIDs"][i]).then((value) {
        setState(() {
          arts.add(value);
        });
      });
      print("nice");
    }

    Future.delayed(Duration(milliseconds: 800), () {
      context.loaderOverlay.hide();
    });

    setState(() {
      counter = i;
    });

    if (counter == collectionObjectId["total"]) {
      setState(() {
        isMax = true;
      });
    }
  }
}
