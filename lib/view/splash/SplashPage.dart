

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../contactsMain/ContactsMainPage.dart';
import '../login/LoginPage.dart';
import 'bloc/SplashBloc.dart';

class SplashPage extends StatefulWidget {

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> with TickerProviderStateMixin {

  late final AnimationController animationControllerLogo;
  late final AnimationController animationControllerName;
  late final Animation<double> animationLogo;
  late final Animation<double> animationName;
  late final CurvedAnimation curvedAnimationLogo;
  late final CurvedAnimation curvedAnimationName;

  @override
  void initState() {
    super.initState();

    animationControllerLogo = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    animationControllerName = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    curvedAnimationLogo = CurvedAnimation(parent: animationControllerLogo, curve: Curves.easeIn);
    curvedAnimationName = CurvedAnimation(parent: animationControllerName, curve: Curves.easeIn);

    animationLogo = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(curvedAnimationLogo);
    animationName = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(curvedAnimationName);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      animationControllerLogo.animateTo(1.0);
      Future.delayed(const Duration(milliseconds: 2000), (){
        animationControllerName.animateTo(1.0);
      });

    });
  }

  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => SplashBloc(SplashInitialState()),
      child: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {

          return BlocListener<SplashBloc, SplashState>(
              listener: (context, state){

                if (state is SplashGoToNextStepState) {
                  if (state.isLoggedIn) {
                    Timer(Duration(milliseconds: 2500),(){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ContactsMainPage()));
                    });
                  } else {
                    Timer(Duration(milliseconds: 2500),(){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage())
                      );
                    });
                  }
                }
              },
              child: Scaffold(
                body: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/splash_page_background.png"),
                        fit: BoxFit.cover),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(top: 280),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FadeTransition(
                                      opacity: animationLogo,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/main_logo.png"),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                    ),
                                    FadeTransition(
                                      opacity: animationName,
                                      child: Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/main_name_image.png"),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
        },
      ),
    );
  }
}











