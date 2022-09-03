import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stdev_contact/view/splash/SplashPage.dart';

import 'di/di.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();

  return runZonedGuarded(() async {
    runApp(MyApp());
  }, (error, stack) {
    print(stack);
    print(error);
  });
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: SplashPage(),
    );
  }
}
