import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:museum/pages/home.dart';
import 'package:museum/services/database_connection.dart';
import 'package:museum/utils/helper.dart';
import 'package:museum/widgets/error_message.dart';
import 'package:museum/widgets/input_widget.dart';
import 'package:museum/widgets/primary_button.dart';

class LoginForm extends StatefulWidget {

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool isHidden = true;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ErrorMessage(message: errorMessage),
              InputWidget(
                hintText: "Email Address",
                textcontroller: _email,
                prefixIcon: FlutterIcons.mail_ant,
              ),
              SizedBox(height: 15.0),
              InputWidget(
                hintText: "Password",
                prefixIcon: FlutterIcons.lock_ant,
                isHidden: isHidden,
                isSuffixIconNeeded: true,
                textcontroller: _password,
                onTap: setPasswordVisibility,
              ),
              SizedBox(height: 25.0),
              PrimaryButton(
                text: "Login",
                onPressed: login,
              ),
              SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "OR",
                      style: TextStyle(),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: logInUsingGoogle,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.0),
                      height: ScreenUtil().setHeight(53.0),
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/google.svg",
                            width: 30.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Google",
                            style: TextStyle(
                              color: Color.fromRGBO(105, 108, 121, 1),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setPasswordVisibility() {
    setState(() {
        isHidden = !isHidden;
    });
  }

  void login() async {

    if (_email.text.isEmpty && _password.text.isEmpty) {
      setState(() {
        errorMessage = "Fields cannot be empty.";      
      });
      return;
    }

    if (_email.text.isEmpty) {
      setState(() {
        errorMessage = "Email is required.";      
      });
      return;
    } 

    if (_password.text.isEmpty) {
      setState(() {
        errorMessage = "Password is required.";      
      });
      return;
    }

    context.loaderOverlay.show();
    String res;
    res = await signIn(email: _email.text, password: _password.text);

    context.loaderOverlay.hide();
    if (res == "successful") {
      Helper.nextScreenWithoutPrevious(context, Home());
      return;
    }

    setState(() {
      errorMessage = res;    
    });
  }

  void logInUsingGoogle() async {
    context.loaderOverlay.show();
    bool res = await loginWithGoogle();

    context.loaderOverlay.hide();
    if (res) {
      Helper.nextScreenWithoutPrevious(context, Home());
      return;
    }
    
    setState(() {errorMessage = "Cannot Perform Action.";});
  }
}
