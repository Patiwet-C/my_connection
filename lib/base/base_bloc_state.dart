import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:my_connection/base/base_bloc.dart';
import 'package:my_connection/base/base_state.dart';
import 'package:my_connection/di/configure_dependencies.dart';
import 'package:my_connection/i18n/strings.g.dart';
import 'package:my_connection/routers/app_navigator.dart';
import 'package:my_connection/styles/app_colour.dart';
import 'package:my_connection/styles/app_text_styles.dart';
import 'package:my_connection/widgets/loading_dialog.dart';

abstract class LazyLoadingProvider {
  bool get isBottomScreen;
}

/// Base bloc state
///
/// [BLOC] is the bloc class.
///
/// [I] is the bloc interface.
///
/// [T] is the stateful widget.
abstract class BaseBlocState<
  BLOC extends BaseBloc<I>,
  I,
  T extends StatefulWidget
>
    extends BaseState<T>
    with RouteAware
    implements LazyLoadingProvider {
  late final BLOC _bloc;
  late AppTextTheme _styles;
  late final ScrollController _scrollController = ScrollController();
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final AppNavigator _appNavigator;

  I get bloc => _bloc.bloc;
  AppTextTheme get styles => _styles;
  GlobalKey<FormState> get formKey => _formKey;
  ScrollController get scrollController => _scrollController;
  Translations get translation => t;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appNavigator.routeObserver?.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _bloc = provideBloc(GetIt.I);
    _scrollController.addListener(_scrollListener);
    _appNavigator = getIt<AppNavigator>();
    _styles = AppTextStyles.get();
    _bloc.onInit();

    // Listen to theme changes
    AppTextStyles.themeNotifier.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _bloc.onDispose();
    getIt<AppNavigator>().routeObserver?.unsubscribe(this);
    AppTextStyles.themeNotifier.removeListener(_onThemeChanged);
  }

  void _onThemeChanged() {
    if (mounted) {
      setState(() {
        _styles = AppTextStyles.get();
      });
    }
  }

  @protected
  BLOC provideBloc(GetIt getIt) {
    return getIt<BLOC>();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        _scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      _bloc.onLoadNextItems();
    }
  }

  @override
  bool get isBottomScreen =>
      _scrollController.offset >= _scrollController.position.maxScrollExtent;

  /// RouteAware methods
  @override
  @mustCallSuper
  void didPop() {
    super.didPop();
    _bloc.didPop();
  }

  @override
  @mustCallSuper
  void didPopNext() {
    super.didPopNext();
    _bloc.didPopNext();
  }

  @override
  @mustCallSuper
  void didPush() {
    super.didPush();
    _bloc.didPush();
  }

  @override
  @mustCallSuper
  void didPushNext() {
    super.didPushNext();
    _bloc.didPushNext();
  }

  String? getPageTitle() => null;

  bool canPop() => _appNavigator.canPop();

  bool get isShowAppBar => true;

  Widget? getAppBarTitle() => null;

  PreferredSizeWidget? getAppBar(BuildContext context) {
    return isShowAppBar && canPop()
        ? AppBar(
            title: getAppBarTitle(),
            backgroundColor: AppColour.transparent,
            automaticallyImplyLeading: canPop(),
            leading: IconButton(
              onPressed: () => _appNavigator.pop(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          )
        : null;
  }

  Widget? getFloatingActionButton() {
    return null;
  }

  Widget? getBottomNavigationBar() {
    return null;
  }

  Widget? getDrawer() {
    return null;
  }

  Widget? getEndDrawer() {
    return null;
  }

  bool onWillPop() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: onWillPop(),
      child: Stack(
        children: <Widget>[
          Scaffold(
            key: _formKey,
            appBar: getAppBar(context),
            body: SingleChildScrollView(
              controller: _scrollController,
              child: buildPageContent(context),
            ),
            floatingActionButton: getFloatingActionButton(),
            bottomNavigationBar: getBottomNavigationBar(),
            drawer: getDrawer(),
            endDrawer: getEndDrawer(),
          ),
          LoadingDialog.stream(
            _bloc.isLoading,
            onCancel: _bloc.onCancelLoading,
          ),
        ],
      ),
    );
  }

  Widget buildPageContent(BuildContext context);
}
