
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stdev_contact/di/di.dart';
import 'package:stdev_contact/utils/InternetConnectionManager.dart';

import '../../../model/database/databaseModel/LoginDetail.dart';
import '../../../model/database/dbHelper.dart';

part 'SplashEvent.dart';
part 'SplashState.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {

  SplashBloc(SplashState initialState) : super(initialState){
    on<SplashEvent>(onSplashEvent);

    initializeSPlash();
    }

  void onSplashEvent(SplashEvent event, Emitter<SplashState> emit) async {
  }

  void initializeSPlash() async {

    InternetConnectionManager internetConnectionManager = getIt();
    bool isInternetConnected = await internetConnectionManager.checkConnection();

    if (isInternetConnected) {

      bool isForceUpdate = await checkForceUpdateConnection();

      if (isForceUpdate) {

        emit(SplashForceUpdateState());

      } else {

        bool isLoggedIn = await checkLogin();
        emit(SplashGoToNextStepState(isLoggedIn));

      }
    } else {

      emit(SplashNoInternetState());

    }
  }

  Future<bool> checkForceUpdateConnection() async {

    bool isForceUpdate = false;

    // We could check force update here using API

    return isForceUpdate;
  }

  Future<bool> checkLogin() async {

    bool isLoggedIn = true;

    var LoggedInList = await DBHelper.instance.readAllLoginDetails();

    if (LoggedInList.length == 0) {
      try {
        var bool = await DBHelper.instance.createLoginDetailTable(new LoginDetail.withoutId(false));
        isLoggedIn = false;

      } catch(_){

        isLoggedIn = false;
      }
    } else {

      var loginDetail = await DBHelper.instance.readLoginDetail(1);

      if (loginDetail.isLoggedIn) {

        isLoggedIn = true;
      } else {

        isLoggedIn = false;
      }
    }

    return isLoggedIn;
  }

}



