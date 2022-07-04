import 'package:auto_route/annotations.dart';

import '../ui/screens/details_screen.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/imageViewScreen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
    routes: <AutoRoute>[
      AutoRoute(page: HomeScreen,initial: true),
      AutoRoute(page: DetailsScreen),
      AutoRoute(page: ImageViewScreen),  ]
)
class $AppRouter {}