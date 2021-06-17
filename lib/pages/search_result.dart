import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:museum/models/property.dart';
import 'package:museum/services/api_connection.dart';
import 'package:museum/utils/constants.dart';
import 'package:museum/widgets/art_card.dart';

class SearchResult extends StatefulWidget {
  Map filteredObjectId;
  SearchResult({this.filteredObjectId});

  @override
  _SearchResultState createState() =>
      _SearchResultState(filteredObjectId: this.filteredObjectId);
}

class _SearchResultState extends State<SearchResult> with Api {
  bool noDisplay = false;
  bool isLoadingForCards = true;
  Map filteredObjectId;
  List arts = [];
  int counter = 0;
  bool isMax = false;

  _SearchResultState({this.filteredObjectId});

  initState() {
    setItems();
    super.initState();
  }

  void setItems() {

    if (filteredObjectId["total"] == 0) {
      setState(() {
        isLoadingForCards = false;
      });
      return;
    }
    
    filteredObjectId["objectIDs"].shuffle();

    int i;
    for (i = 1; i < 30 && i < filteredObjectId["total"]; i++) {
      getObjectInfo(id: filteredObjectId["objectIDs"][i]).then((value) {
        setState(() {
          arts.add(value);
          isLoadingForCards = false;
          print(arts);
        });
      });
    }

    setState(() {
      counter = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Results"),
      ),
      body: LoaderOverlay(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${filteredObjectId['total']} Arts Found",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Constants.blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                                  isPublicDomain: arts[index]["isPublicDomain"],
                                  isHighlight: arts[index]["isHighlight"]);

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
    );
  }

  void fetch() async {
    context.loaderOverlay.show();

    int i;
    for (i = counter; i < (counter + 5) && i < filteredObjectId["total"]; i++) {
      getObjectInfo(id: filteredObjectId["objectIDs"][i]).then((value) {
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

    if (counter == filteredObjectId["total"]) {
      setState(() {
        isMax = true;
      });
    }
  }
}
