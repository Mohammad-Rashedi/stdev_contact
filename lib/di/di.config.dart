// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../model/network/retApi.dart' as _i5;
import '../utils/InternetConnectionManager.dart' as _i3;
import '../utils/PakageInfoHelper.dart' as _i4;
import '../utils/snackBarHelper.dart' as _i6;
import '../utils/StringManager.dart' as _i7;
import 'injector_module.dart' as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final serviceModule = _$ServiceModule();
  gh.singleton<_i3.InternetConnectionManager>(
      serviceModule.internetConnectionManager);
  gh.singleton<_i4.PackageInfoHelper>(serviceModule.packageInfoHelper);
  gh.singleton<_i5.RestClient>(serviceModule.client);
  gh.singleton<_i6.SnackBarHelper>(serviceModule.snackBarHelper);
  gh.singleton<_i7.StringManager>(serviceModule.stringManager);
  return get;
}

class _$ServiceModule extends _i8.ServiceModule {}
