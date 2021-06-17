import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:museum/pages/search_result.dart';
import 'package:museum/services/api_connection.dart';
import 'package:museum/utils/constants.dart';
import 'package:museum/utils/helper.dart';
import 'package:museum/widgets/button_group_spaced.dart';
import 'package:museum/widgets/primary_button.dart';

class Filters extends StatefulWidget {
  Map departmentObject;

  Filters({this.departmentObject});
  @override
  _FiltersState createState() =>
      _FiltersState(departmentObject: this.departmentObject);
}

class _FiltersState extends State<Filters> with Api {
  Map departmentObject;
  Map filteredObjectId = {};
  int activeIndex = 0;
  _FiltersState({this.departmentObject});


  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Filters"),
              ),
              body: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Select A Category",
                              style: TextStyle(
                                color: Constants.blackColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            ButtonGroupSpaced(
                                departments: departmentObject["departments"],
                                activeIndex: activeIndex,
                                callBack: (currentIndex) {
                                  setState(() {
                                    activeIndex = currentIndex;
                                  });
                                }),
                            SizedBox(
                              height: 25.0,
                            ),
                            PrimaryButton(
                              text: "Apply Filter",
                              onPressed: () {
                                filterList();
                              },
                            )
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

  filterList() async {
    context.loaderOverlay.show();
    int id = departmentObject["departments"][activeIndex]["departmentId"];
    var res = await getFilteredItems(id);
    context.loaderOverlay.hide();

    Helper.nextScreen(context, SearchResult(filteredObjectId: res));
    setState(() {
      filteredObjectId = res;
    });
  }
}
