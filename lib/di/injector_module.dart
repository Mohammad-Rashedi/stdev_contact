
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import '../model/network/retApi.dart';
import '../utils/InternetConnectionManager.dart';
import '../utils/PakageInfoHelper.dart';
import '../utils/StringManager.dart';
import '../utils/snackBarHelper.dart';



@module
abstract class ServiceModule {

  @singleton
  RestClient get client => RestClient(Dio(BaseOptions(contentType: "application/json")));

  @singleton
  InternetConnectionManager get internetConnectionManager => InternetConnectionManager();

  @singleton
  PackageInfoHelper get packageInfoHelper => PackageInfoHelper();

  @singleton
  StringManager get stringManager => StringManager();

  @singleton
  SnackBarHelper get snackBarHelper => SnackBarHelper();

}