import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:museum/models/property.dart';
import 'package:museum/utils/constants.dart';

class ArtCard extends StatelessWidget {
  final Property property;
  ArtCard({this.property});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (property.primaryImageSmall != "") {
          return showDialog(
              context: context,
              builder: (context) {
                return myDialog(context);
              });
        }
      },
      child: Container(
        height: ScreenUtil().setHeight(250.0),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: property.primaryImageSmall != ""
                            ? NetworkImage(property.primaryImageSmall)
                            : AssetImage("assets/images/image-not-found.png"),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        width: 45.0,
                        height: 45.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          FlutterIcons.favorite_mdi,
                          color: this.property.isHighlight
                              ? Color.fromRGBO(255, 136, 0, 1)
                              : Color(0xFFC4C4C4),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -15.0,
                    left: 10.0,
                    child: Container(
                      width: 45.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: this.property.isPublicDomain
                            ? Constants.primaryColor
                            : Color.fromRGBO(255, 136, 0, 1),
                      ),
                      child: Center(
                        child: Text(
                          this.property.isPublicDomain ? "PUBLIC" : "PRIVATE",
                          style: TextStyle(
                            fontSize: 8.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          formatMe(property.title),
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      // Text(
                      //   property.objectName,
                      //   style: TextStyle(
                      //     fontSize: 17.0,
                      //     color: Constants.primaryColor,
                      //   ),
                      // )
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    property.department,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Color(0xFF343434),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        FlutterIcons.map_pin_fea,
                        size: 15.0,
                        color: Color.fromRGBO(255, 136, 0, 1),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        property.city.isEmpty && property.country.isEmpty
                            ? "Unknown Origin"
                            : "${property.city.isEmpty ? '' : '${property.city}, '} ${property.country.isEmpty ? '' : '${property.country}'}",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Color(0xFF343434),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String formatMe(String text) {
    if (text.length >= 100) return text.substring(0, 80) + "...";

    return text;
  }

  Widget myDialog(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.fromLTRB(0, 40, 0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      elevation: 16,
      child: Container(
        height: MediaQuery.of(context).size.height - 360,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            image: DecorationImage(
              image: NetworkImage(property.primaryImageSmall),
              fit: BoxFit.fill,
            )),
      ),
    );
  }
}
