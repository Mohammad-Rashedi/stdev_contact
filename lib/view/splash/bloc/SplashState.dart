
part of 'SplashBloc.dart';

abstract class SplashState {
  const SplashState();
}

class SplashInitialState extends SplashState {}
class SplashNoInternetState extends SplashState {}
class SplashForceUpdateState extends SplashState {}
class SplashGoToNextStepState extends SplashState {
  bool isLoggedIn;
  SplashGoToNextStepState(this.isLoggedIn);
}




