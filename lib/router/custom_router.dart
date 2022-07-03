import 'package:auto_route/annotations.dart';

import '../ui/screens/details_screen.dart';
import '../ui/screens/home_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
    routes: <AutoRoute>[
      AutoRoute(page: HomeScreen,initial: true),
      AutoRoute(page: DetailsScreen),
    ]
)
class $AppRouter {}