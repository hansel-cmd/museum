import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:museum/pages/home.dart';
import 'package:museum/services/database_connection.dart';
import 'package:museum/utils/helper.dart';
import 'package:museum/widgets/error_message.dart';
import 'package:museum/widgets/input_widget.dart';
import 'package:museum/widgets/primary_button.dart';

class RegisterForm extends StatefulWidget{
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool isHidden = true;
  String errorMessage = "";


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ErrorMessage(message: errorMessage),
            InputWidget(
              hintText: "Email Address",
              prefixIcon: FlutterIcons.mail_ant,
              textcontroller: _email,
            ),
            SizedBox(height: 15.0),
            InputWidget(
              hintText: "Password",
              prefixIcon: FlutterIcons.lock_ant,
              isHidden: isHidden,
              isSuffixIconNeeded: true,
              textcontroller: _password,
              onTap: setPasswordVisibility
            ),
            SizedBox(height: 25.0),
            PrimaryButton(
              text: "Register",
              onPressed: registerMe,
            ),
          ],
        ),
      ),
    );
  }

  void setPasswordVisibility() {
    setState(() {
        isHidden = !isHidden;
    });
  }

  void registerMe() async {

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

    String res;

    res = await register(email: _email.text, password: _password.text);
    if (res == "successful") {
      Helper.nextScreenWithoutPrevious(context, Home());
      return;
    }
  
    setState(() {
      errorMessage = res;    
    });
    
  }
}
