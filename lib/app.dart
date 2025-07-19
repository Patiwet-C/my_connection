import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_connection/base/core_platform.dart';
import 'package:my_connection/constants/storage_key.dart';
import 'package:my_connection/di/configure_dependencies.dart';
import 'package:my_connection/i18n/strings.g.dart';
import 'package:my_connection/routers/app_navigator.dart';
import 'package:my_connection/routers/custom_route_observer.dart';
import 'package:my_connection/routers/navigation_router.dart';
import 'package:my_connection/styles/app_colour.dart';
import 'package:my_connection/styles/app_text_styles.dart';
import 'package:my_connection/utils/local_storage.dart';
import 'package:rxdart/rxdart.dart';

class MyConnectionApp extends StatefulWidget {
  final String? initialRoute;

  const MyConnectionApp({super.key, this.initialRoute});

  @override
  State<MyConnectionApp> createState() => _MyConnectionAppState();

  static _MyConnectionAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyConnectionAppState>()!;
}

class _MyConnectionAppState extends State<MyConnectionApp> {
  final _appKey = GlobalKey();
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _routeObserver = CustomRouteObserver<ModalRoute<void>>();

  late final BehaviorSubject<bool> _isDarkMode;

  late AppTextTheme _styles;

  @override
  void initState() {
    super.initState();
    final localStorage = getIt<LocalStorage>();
    final locale =
        localStorage.getCachedData<int>(StorageKey.languageSetting) ?? 0;
    getIt<AppNavigator>().setNavigatorKey(_navigatorKey);
    getIt<AppNavigator>().setRouteObserver(_routeObserver);
    _isDarkMode = BehaviorSubject<bool>.seeded(
      localStorage.getCachedData<bool>(StorageKey.darkModeSetting) ?? false,
    );

    LocaleSettings.setLocale(locale == 0 ? AppLocale.en : AppLocale.th);
    _styles = AppTextStyles.get();
  }

  void changeTheme(bool isDarkMode) {
    _isDarkMode.add(isDarkMode);
    setState(() {
      _styles = AppTextStyles.get();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _isDarkMode,
      builder: (_, snapshot) {
        final bool isDarkMode = snapshot.data ?? false;

        return MaterialApp(
          key: _appKey,
          locale: TranslationProvider.of(context).flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            textTheme: _styles.getTextTheme(),
            colorScheme: AppColour.getColorScheme(false),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            textTheme: _styles.getTextTheme(),
            colorScheme: AppColour.getColorScheme(true),
          ),
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          onGenerateRoute: NavigationRouter.router,
          navigatorKey: _navigatorKey,
          initialRoute:
              widget.initialRoute ?? (CorePlatform.isWeb ? '/' : null),
          navigatorObservers: [_routeObserver],
          builder: (BuildContext context, Widget? child) {
            CorePlatform.refresh(context);
            final rootMediaQuery = MediaQuery.of(context);

            return MediaQuery(
              data: rootMediaQuery.copyWith(textScaler: TextScaler.linear(1.0)),
              child: child ?? Container(),
            );
          },
        );
      },
    );
  }
}
