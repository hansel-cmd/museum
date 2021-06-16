import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:museum/utils/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(12.0),
            child: Center(
              child: SpinKitWave(
                  size: 50, color: Constants.primaryColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Please wait for a bit \nwhile we are preparing...\nWala silay pagination gihatag.\n\n\n\nWala sad silay gihatag na\n number of items \nna pwede i-fetch. Sadt.",
            style: TextStyle(
              fontSize: 16.0,
              color: Constants.blackColor,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
