

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:provider/provider.dart';
import 'package:stdev_contact/utils/snackBarHelper.dart';
import 'package:stdev_contact/view/contactsMain/ContactsMainPage.dart';
import '../../di/di.dart';
import '../../utils/InternetConnectionManager.dart';
import '../../values/MyColors.dart';
import 'LoginPageProvider.dart';

class LoginPage extends StatefulWidget {

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  LoginPageProvider loginPageProvider = LoginPageProvider();
  final myControllerUserName = TextEditingController();
  final myControllerPassword = TextEditingController();
  var focusNode = FocusNode();
  SnackBarHelper snackBarHelper = getIt();
  InternetConnectionManager internetConnectionManager =  getIt();

  @override
  void initState() {

    super.initState();

    focusNode.addListener(() {
      loginPageProvider.setIsPasswordTyped(focusNode.hasFocus);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAppVersion();
    });
  }

  @override
  void dispose() {
    myControllerUserName.dispose();
    myControllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: ChangeNotifierProvider(
          create: (context) => LoginPageProvider(),
          child: Builder (
          builder: (context) {
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/images/login_background.png"
                    ),
                    fit: BoxFit.cover
                  )
                ),
                child: Center(
                  child: Padding(padding: EdgeInsets.all(0.0),
                    child: Consumer<LoginPageProvider>(
                      builder: (context, provider, child){
                        loginPageProvider = provider;
                        return SingleChildScrollView(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(padding: const EdgeInsets.all(0.0),
                                child: SizedBox(
                                  height: 95.0,
                                  child: Image.asset("assets/images/main_logo.png"),
                                ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                                  child: Text(
                                    "${provider.version}",
                                    style: TextStyle(
                                        color: MyColors.VersionTextLoginPageColor,
                                        fontFamily: "Roboto",
                                        fontSize: 10
                                    ),
                                  ),
                                  ),
                                Padding(padding: const EdgeInsets.fromLTRB(10.0,60.0,10.0,5.0),
                                child: SizedBox(
                                  height: 50.0,
                                  child: Card(
                                    color: MyColors.TextFieldLoginBackground,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5))
                                    ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 3.0),
                                        child: TextField(
                                          controller: myControllerUserName,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                top: 5),
                                            hintText: "Email",
                                            hintStyle: TextStyle(
                                              color: MyColors.LabelColorTextFieldsLoginPageColor,
                                              fontFamily: "Roboto",
                                            ),
                                            alignLabelWithHint: true,
                                            prefixIcon: new IconButton(
                                              icon: new Image.asset('assets/images/profile_icon.png',width: 25.0,height: 25.0,
                                                color: MyColors.TextFieldsLoginIconColor,),
                                              onPressed: null,
                                            ),
                                          ),
                                          style: TextStyle(
                                            color: MyColors.TextColorTextFieldsLoginPageColor,
                                            fontFamily: "Roboto"
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                  ),
                                ),
                                ),
                                Padding(padding: const EdgeInsets.fromLTRB(10.0,0.0,10.0,5.0),
                                  child: SizedBox(
                                    height: 50.0,
                                    child: Card(
                                      color: MyColors.TextFieldLoginBackground,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 3.0),
                                          child: TextField(
                                            focusNode: focusNode,
                                            controller: myControllerPassword,
                                            obscureText: provider.isPasswordHide,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                 top: 5),
                                              hintText: "Password",
                                              hintStyle: TextStyle(
                                                color: MyColors.LabelColorTextFieldsLoginPageColor,
                                                fontFamily: "Roboto",
                                              ),
                                              alignLabelWithHint: true,
                                              prefixIcon: (provider.isPasswordTyped) ?
                                              (provider.isPasswordHide)?
                                              new IconButton(
                                                icon: new Icon(Icons.visibility),
                                                color: MyColors.TextFieldsLoginIconColor,
                                                onPressed: (){
                                                  provider.setIsPasswordHide();
                                                },
                                              )
                                                  :
                                              new IconButton(
                                                icon: new Icon(Icons.visibility_off),
                                                color: MyColors.TextFieldsLoginIconColor,
                                                onPressed: (){
                                                  provider.setIsPasswordHide();
                                                },
                                              )
                                                  :
                                              new IconButton(
                                                icon: new Image.asset('assets/images/password_icon.png',width: 25.0,height: 25.0,
                                                  color: MyColors.TextFieldsLoginIconColor,),
                                                onPressed: null,
                                              ),
                                            ),
                                            style: TextStyle(
                                                color: MyColors.TextColorTextFieldsLoginPageColor,
                                                fontFamily: "Roboto"
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(padding: const EdgeInsets.fromLTRB(10.0,15.0,10.0,5.0),
                                  child: SizedBox(
                                    height: 50.0,
                                    width: double.infinity,
                                    child: Card(
                                      color: MyColors.LoginButtonBackground,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 0.0),
                                          child: TextButton(
                                            child: (provider.isLoading) ?
                                            SpinKitFadingCircle(
                                              color: MyColors.LoginButtonTextColor,
                                              size: 25,
                                            )
                                                :
                                            Text(
                                              "Login",
                                              style: TextStyle(
                                                color: MyColors.LoginButtonTextColor,
                                                fontSize: 15,
                                                fontFamily: "Roboto"
                                              ),
                                            ),
                                            onPressed: () {
                                              if (provider.isLoading) {
                                                showIsLoadingSnackBar();
                                              } else {
                                                checkInputs();
                                              }
                                            },
                                          ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void getAppVersion() {
    loginPageProvider.getAppVersion();
  }

  void checkInputs() {

    String userName = myControllerUserName.text.replaceAll(new RegExp(r"\s+"), "");
    String password = myControllerPassword.text.replaceAll(new RegExp(r"\s+"), "");

    if (userName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarHelper.showErrorSnackBar("Please enter email."));
    } else if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarHelper.showErrorSnackBar("Please enter password."));
    } else {
      loginPageProvider.setIsLoading(true);
      validateUser();
    }
  }

  void showIsLoadingSnackBar() {
    snackBarHelper.showErrorSnackBar("Please wait.");
  }

  void validateUser() async {
      String password = myControllerPassword.text;
      bool isInternetConnected = await internetConnectionManager.checkConnection();

      if (isInternetConnected) {
       //check login using API
          loginPageProvider.updateLoginDetailInDB();
          Navigator.push(context, MaterialPageRoute(builder: (context) => ContactsMainPage()));
          loginPageProvider.setIsLoading(false);

      } else {
        ScaffoldMessenger.of(context).showSnackBar(snackBarHelper.showErrorSnackBar("No connection to Internet."));
        loginPageProvider.setIsLoading(false);
      }
  }

}