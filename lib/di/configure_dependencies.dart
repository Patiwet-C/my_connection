import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:my_connection/di/configure_dependencies.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
  // Add web support
  includeMicroPackages: true,
)
Future<void> configureDependencies() async => $initGetIt(getIt);
