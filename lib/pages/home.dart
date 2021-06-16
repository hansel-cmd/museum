import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:museum/pages/filters.dart';
import 'package:museum/utils/constants.dart';
import 'package:museum/utils/helper.dart';
import 'package:museum/utils/static_data.dart';
import 'package:museum/widgets/bottom_bar.dart';
import 'package:museum/widgets/input_widget.dart';
import 'package:museum/widgets/property_card.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      body: SingleChildScrollView(
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
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Find a Thousand Homes\n",
                        style: TextStyle(
                          fontSize: 22.0,
                          height: 1.3,
                          color: Color.fromRGBO(22, 27, 40, 70),
                        ),
                      ),
                      TextSpan(
                        text: "For Sell & Rent",
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w800,
                          color: Constants.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputWidget(
                        height: 44.0,
                        hintText: "Search",
                        prefixIcon: FlutterIcons.search1_ant,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    FlatButton(
                      height: ScreenUtil().setHeight(44.0),
                      onPressed: () {
                        Helper.nextScreen(context, Filters());
                      },
                      color: Constants.primaryColor,
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: ScreenUtil().setHeight(52.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(255, 136, 0, 1),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          "For Sell",
                          style: TextStyle(
                            color: Color.fromRGBO(255, 136, 0, 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: ScreenUtil().setHeight(52.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(255, 136, 0, 1),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          "For Rent",
                          style: TextStyle(
                            color: Color.fromRGBO(255, 136, 0, 1),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New Properties",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Constants.blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "View all",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.0,
                ),
                ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 15.0,
                    );
                  },
                  itemCount: StaticData.sampleProperties.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return PropertyCard(
                      property: StaticData.sampleProperties[index],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
