

import 'package:flutter/cupertino.dart';

class ScreenSizeHelper {

  BuildContext context;
  ScreenSizeHelper(this.context);

  double heightUnit = 1;
  double widthUnit = 2;
  init (){

    double width = MediaQuery. of(context). size. width ;
    double height = MediaQuery. of(context). size. height;
  }

}