import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
  Map collection_object_id = {};
  List arts = [];
  int counter = 0;
  bool isMax = false;

  initState() {
    // print(user);

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
    collection_object_id = res;
    collection_object_id["objectIDs"].shuffle();

    print("next phase na ko");
    
    Map temp = {};
    int i;
    for (i = 1; i < 5 && i < collection_object_id["total"]; i++) {
      temp = await getInfo(collection_object_id["objectIDs"][i]);
      print("nice");
      arts.add(temp);
    }

    // print(arts[0]["title"]);

    setState(() {
      counter = i;
      isLoading = false;
    });
  }

  getInfo(id) async {
    var res = await getObjectInfo(id: id);

    if (res.isEmpty) return {};

    return res;
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
                            onPressed: () {
                              Helper.nextScreen(context, Filters());
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
                      noDisplay
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
                              child: ListView.separated(
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 15.0,
                                  );
                                },
                                // itemCount: StaticData.sampleProperties.length,
                                itemCount: arts.length,
                                // physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  Property prop = Property(
                                      title: arts[index]["title"],
                                      objectName: arts[index]["objectName"],
                                      department: arts[index]["department"],
                                      accessionYear: arts[index]["accessionYear"],
                                      city: arts[index]["city"],
                                      country: arts[index]["country"],
                                      primaryImage: arts[index]["primaryImage"],
                                      primaryImageSmall: arts[index]
                                          ["primaryImageSmall"],
                                      additionalImages: arts[index]
                                          ["additionalImages"],
                                      isPublicDomain: arts[index]
                                          ["isPublicDomain"],
                                      isHighlight: arts[index]["isHighlight"]);

                                  return ArtCard(
                                    property: prop,
                                  );
                                },
                              ),
                            ),
                      !isMax
                          ? TextButton(
                              onPressed: fetch,
                              child: Text(
                                "Load More...",
                              ))
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  void fetch() async {

    context.loaderOverlay.show();
    Map temp = {};
    int i;
    for ( i = counter;
        i < (counter + 5) && i < collection_object_id["total"];
        i++) {
      temp = await getInfo(collection_object_id["objectIDs"][i]);
      print("nice");
      arts.add(temp);
    }

    context.loaderOverlay.hide();

    setState(() {
      counter = i;
    });

    if (counter == collection_object_id["total"]) {
      setState(() {
        isMax = true;      
      });
    }
  }

}
