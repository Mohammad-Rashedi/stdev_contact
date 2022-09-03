

import 'package:flutter/material.dart';

import '../values/MyColors.dart';

class SnackBarHelper {

  SnackBar showErrorSnackBar(String? message){

    return SnackBar(

      backgroundColor: MyColors.SnackBarErrorBackgroundColor,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Container(
            width: 250,
            child: Text(
              message!,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: MyColors.SnackBarErrorIconColor,
                  fontFamily: "Roboto",
                  fontSize: 15
              ),
            ),
          ),
          Icon(
            Icons.error_outline,
            color: MyColors.SnackBarErrorTextColor,
          ),
        ],
      ),
      duration: Duration(milliseconds: 1500),

    );
  }

  SnackBar showSuccessSnackBar(String? message){

    return SnackBar(

      backgroundColor: MyColors.SnackBarSuccessBackgroundColor,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            message!,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: MyColors.SnackBarSuccessTextColor,
                fontFamily: "Roboto",
                fontSize: 15
            ),
          ),
          new IconButton(
            icon: new Image.asset('assets/images/tik_icon.png',width: 25.0,height: 25.0,
              color: MyColors.SnackBarSuccessIconColor,),
            onPressed: null,
          ),
        ],
      ),
      duration: Duration(milliseconds: 1000),

    );
  }
}