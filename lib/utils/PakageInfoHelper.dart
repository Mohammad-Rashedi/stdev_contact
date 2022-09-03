

import 'package:package_info/package_info.dart';

class PackageInfoHelper {

  String appName = "";
  String packageName = "";
  String version = "";
  String buildNumber = "";


  Future<String> getVersion() async {

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    this.version = version;
    return this.version;

  }

  Future<String> getAppName() async {

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    this.appName = appName;
    return this.appName;

  }

  Future<String> getPackageName() async {

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String packageName = packageInfo.packageName;
    this.packageName = packageName;
    return this.packageName;

  }

  Future<String> getBuildNumber() async {

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    this.buildNumber = buildNumber;
    return this.buildNumber;

  }

}