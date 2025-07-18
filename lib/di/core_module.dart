import 'package:injectable/injectable.dart';
import 'package:my_connection/constants/app_constants.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class CoreModule {
  @preResolve
  Future<AppConstants> get appConstants async =>
      AppConstants.initialized(await PackageInfo.fromPlatform());

  @preResolve
  @lazySingleton
  Future<SharedPreferences> get sharedPreferences async =>
      await SharedPreferences.getInstance();
}
