import 'dart:io';
import '../main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../SplashScreen/menu_button.dart';
import '../SplashScreen/home_screen.dart';
import '../Validations/error_container.dart';
import '../Validations/textfield_error_container.dart';
import '../Validations/Validations.dart';

class LoginPageRoute extends CupertinoPageRoute {
  LoginPageRoute() : super(builder: (BuildContext context) => LoginScreen());
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  // FacebookLogin fbLogin = new FacebookLogin();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userId = "";
  bool _obscureText = true;
  bool _rememberMe = false;
  bool isPopUpShown = false;
  String errorMsg = "";
  String emailError = '';
  String passwordError = '';

  final TextEditingController _emailController =
      TextEditingController(text: "");
  final TextEditingController _passwordController =
      TextEditingController(text: "");

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("appLifecyle");
    if (Platform.isIOS) {}
  }

  void scrollUpDownFields(double offset, int timeInMilliSec) {
    _scrollController.animateTo(offset,
        curve: Curves.linear, duration: Duration(milliseconds: timeInMilliSec));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: _buildScreenLeading(context),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: InkWell(
          onTap: () {
            // to dismiss the keyboard when the user tabs out of the TextField
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            transform: Matrix4.translationValues(
              0.0,
              0.0,
              0.0,
            ),
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                    controller: _scrollController, child: _showForm()),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                          ),
                        ),
                        _buildMenuButton(context),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildMenuButton(BuildContext context) {
    return MenuButton(
      label: "Login",
      onTap: () {
        setState(() {
          errorMsg = '';
        });
        FocusScope.of(context).requestFocus(FocusNode());
        final bool isvalidEmail = validateEmalField();
        final bool isvalidPassword = validatePasswordField();
        if (isvalidEmail && isvalidPassword) {
          Navigator.pushNamed(context, 'home_screen');
        }
      },
    );
  }

  Widget _showForm() {
    return Container(
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
        ),
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                showSpace(),
                widgetAppNameText(),
                if (errorMsg != null && errorMsg != '')
                  ErrorContainer(errorMsg: errorMsg)
                else
                  showSpace(),
                widgetEmailTextField(),
                if (emailError != null && emailError != '')
                  IndividualErrorContainer(
                    errorMsg: emailError,
                  )
                else
                  Container(),
                widgetPasswordTextField(),
                if (passwordError != null && passwordError != '')
                  IndividualErrorContainer(
                    errorMsg: passwordError,
                  )
                else
                  Container(),
              ],
            )));
  }

  Widget showSpace() {
    final Size screenSize = MediaQuery.of(context).size;
    final double spaceHeight = screenSize.height * 0.075;
    return SizedBox(
      height: spaceHeight,
    );
  }

  Widget widgetAppNameText() {
    return Padding(
        key: Key('appname'),
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        child: Text(
          "Login",
          style: TextStyle(
              fontSize: 32.0,
              color: Colors.black,
              fontWeight: FontWeight.normal),
        ));
  }

  Widget widgetEmailTextField() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: new TextFormField(
        autocorrect: false,
        enableSuggestions: false,
        key: Key('email'),
        controller: _emailController,
        style: TextStyle(
            color: Colors.black54, fontSize: 16, fontWeight: FontWeight.normal),
        cursorColor: Colors.blueAccent,
        keyboardType: TextInputType.emailAddress,
        // Use email input type for emails.
        inputFormatters: [FilteringTextInputFormatter.deny(new RegExp('[ -]'))],
        decoration: new InputDecoration(
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent),
            ),
            hintText: 'Enter email',
            hintStyle:
                TextStyle(fontSize: 12.0, color: Colors.white.withOpacity(0.5)),
            labelText: 'Email'),

        onChanged: (String value) {
          validateEmalField();
        },
      ),
    );
  }

  Widget widgetPasswordTextField() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            TextFormField(
                key: Key('password'),
                controller: _passwordController,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                cursorColor: Colors.blueAccent,
                obscureText: _obscureText,
                // Use email input type for emails.
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(12),
                  FilteringTextInputFormatter.deny(new RegExp('[ -]')),
                ],
                decoration: new InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  errorMaxLines: 3,
                  hintText: 'Enter password',
                  hintStyle: TextStyle(
                      fontSize: 12.0, color: Colors.white.withOpacity(0.5)),
                  labelText: 'Password',
                ),
                onChanged: (String value) {
                  validatePasswordField();
                }),
            Positioned(
              right: 10,
              bottom: 5,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Container(
                  height: 50,
                  width: 50,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      height: 15.53,
                      width: 25.34,
                      child: Icon(_obscureText
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget widgetRegisterText() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
        child: GestureDetector(
          onTap: () {},
        ));
  }

  Widget widgetLoginButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: SizedBox(
        height: 50.0,
        child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            color: Colors.black,
            child: new Text('Login',
                style: new TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.normal)),
            onPressed: () => {}),
      ),
    );
  }

  bool validateEmalField() {
    var validateemail = Validator.validateEmail(_emailController.text);
    if (validateemail == "Enter email address") {
      setState(() {
        emailError = 'Enter email address';
      });
      return false;
    } else if (validateemail == "Enter valid email address") {
      setState(() {
        emailError = 'Enter valid email address';
      });
      return false;
    } else {
      setState(() {
        emailError = '';
      });
      return true;
    }
  }

  bool validatePasswordField() {
    var validatepassword = Validator.validatePassword(_passwordController.text);

    if (validatepassword == "Enter password") {
      setState(() {
        passwordError = "Enter password";
      });
      return false;
    } else if (validatepassword == "Password should be min 8 characters.") {
      setState(() {
        passwordError = 'Password should be min 8 characters.';
      });
      return false;
    } else if (validatepassword ==
        "Password must have at least one Capital letter, number, and special character") {
      setState(() {
        emailError = '';
        passwordError =
            "Password must have at least one Capital letter, number, and special character";
      });
      return false;
    } else {
      setState(() {
        passwordError = '';
      });
      return true;
    }
  }

  Widget _buildScreenLeading(context) {
    return GestureDetector(
      onTap: () {
        // There is nowhere at the moment
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
      ),
    );
  }
}
