import 'package:go_router/go_router.dart';
import '../../features/profile/presentation/pages/all_users_page.dart';
import '../../features/profile/presentation/pages/detail_user_page.dart';

class AppRoutes {
  GoRouter get router => GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: "/",
        name: "all_users",
        pageBuilder: (context, state) =>
            NoTransitionPage(child: AllUsersPage()),
        routes: [
          GoRoute(
            path: "detail-user",
            name: "detail_user",
            pageBuilder: (context, state) =>
                NoTransitionPage(child: UserDetailPage(state.extra as int)),
          ),
        ],
      ),
    ],
  );
}
