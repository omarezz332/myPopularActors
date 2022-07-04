// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../models/core/popular_person.dart' as _i6;
import '../ui/screens/details_screen.dart' as _i2;
import '../ui/screens/home_screen.dart' as _i1;
import '../ui/screens/imageViewScreen.dart' as _i3;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    DetailsRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsRouteArgs>();
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.DetailsScreen(
              key: args.key, popularPerson: args.popularPerson));
    },
    ImageViewRoute.name: (routeData) {
      final args = routeData.argsAs<ImageViewRouteArgs>();
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.ImageViewScreen(args.imageUrl, key: args.key));
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(HomeRoute.name, path: '/'),
        _i4.RouteConfig(DetailsRoute.name, path: '/details-screen'),
        _i4.RouteConfig(ImageViewRoute.name, path: '/image-view-screen')
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.DetailsScreen]
class DetailsRoute extends _i4.PageRouteInfo<DetailsRouteArgs> {
  DetailsRoute({_i5.Key? key, required _i6.Results popularPerson})
      : super(DetailsRoute.name,
            path: '/details-screen',
            args: DetailsRouteArgs(key: key, popularPerson: popularPerson));

  static const String name = 'DetailsRoute';
}

class DetailsRouteArgs {
  const DetailsRouteArgs({this.key, required this.popularPerson});

  final _i5.Key? key;

  final _i6.Results popularPerson;

  @override
  String toString() {
    return 'DetailsRouteArgs{key: $key, popularPerson: $popularPerson}';
  }
}

/// generated route for
/// [_i3.ImageViewScreen]
class ImageViewRoute extends _i4.PageRouteInfo<ImageViewRouteArgs> {
  ImageViewRoute({required String? imageUrl, _i5.Key? key})
      : super(ImageViewRoute.name,
            path: '/image-view-screen',
            args: ImageViewRouteArgs(imageUrl: imageUrl, key: key));

  static const String name = 'ImageViewRoute';
}

class ImageViewRouteArgs {
  const ImageViewRouteArgs({required this.imageUrl, this.key});

  final String? imageUrl;

  final _i5.Key? key;

  @override
  String toString() {
    return 'ImageViewRouteArgs{imageUrl: $imageUrl, key: $key}';
  }
}
