import 'package:auto_route/annotations.dart';

import '../screens/home.dart';
import '../screens/preferred_city.dart';
import '../screens/settings.dart';

@MaterialAutoRouter(routes: <AutoRoute>[
  MaterialRoute(page: HomePage, initial: true),
  MaterialRoute(page: SettingPage),
  MaterialRoute(page: PreferredCity),
])
class $AppRouter {}
