// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../screens/home.dart' as _i1;
import '../screens/preferred_city.dart' as _i3;
import '../screens/settings.dart' as _i2;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    HomePageRoute.name: (routeData) {
      final args = routeData.argsAs<HomePageRouteArgs>(
          orElse: () => const HomePageRouteArgs());
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.HomePage(
          key: args.key,
          recentCity: args.recentCity,
          navigated: args.navigated,
        ),
      );
    },
    SettingPageRoute.name: (routeData) {
      final args = routeData.argsAs<SettingPageRouteArgs>(
          orElse: () => const SettingPageRouteArgs());
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.SettingPage(key: args.key),
      );
    },
    PreferredCityRoute.name: (routeData) {
      final args = routeData.argsAs<PreferredCityRouteArgs>(
          orElse: () => const PreferredCityRouteArgs());
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.PreferredCity(key: args.key),
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          HomePageRoute.name,
          path: '/',
        ),
        _i4.RouteConfig(
          SettingPageRoute.name,
          path: '/setting-page',
        ),
        _i4.RouteConfig(
          PreferredCityRoute.name,
          path: '/preferred-city',
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomePageRoute extends _i4.PageRouteInfo<HomePageRouteArgs> {
  HomePageRoute({
    _i5.Key? key,
    String? recentCity,
    bool? navigated,
  }) : super(
          HomePageRoute.name,
          path: '/',
          args: HomePageRouteArgs(
            key: key,
            recentCity: recentCity,
            navigated: navigated,
          ),
        );

  static const String name = 'HomePageRoute';
}

class HomePageRouteArgs {
  const HomePageRouteArgs({
    this.key,
    this.recentCity,
    this.navigated,
  });

  final _i5.Key? key;

  final String? recentCity;

  final bool? navigated;

  @override
  String toString() {
    return 'HomePageRouteArgs{key: $key, recentCity: $recentCity, navigated: $navigated}';
  }
}

/// generated route for
/// [_i2.SettingPage]
class SettingPageRoute extends _i4.PageRouteInfo<SettingPageRouteArgs> {
  SettingPageRoute({_i5.Key? key})
      : super(
          SettingPageRoute.name,
          path: '/setting-page',
          args: SettingPageRouteArgs(key: key),
        );

  static const String name = 'SettingPageRoute';
}

class SettingPageRouteArgs {
  const SettingPageRouteArgs({this.key});

  final _i5.Key? key;

  @override
  String toString() {
    return 'SettingPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.PreferredCity]
class PreferredCityRoute extends _i4.PageRouteInfo<PreferredCityRouteArgs> {
  PreferredCityRoute({_i5.Key? key})
      : super(
          PreferredCityRoute.name,
          path: '/preferred-city',
          args: PreferredCityRouteArgs(key: key),
        );

  static const String name = 'PreferredCityRoute';
}

class PreferredCityRouteArgs {
  const PreferredCityRouteArgs({this.key});

  final _i5.Key? key;

  @override
  String toString() {
    return 'PreferredCityRouteArgs{key: $key}';
  }
}
