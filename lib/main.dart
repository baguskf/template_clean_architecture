import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:template_clean_architecture/features/profile/presentation/bloc/profile_bloc.dart';
import 'injection.dart';
import 'observer.dart';
import 'core/routes/app_routes.dart';

void main() async {
  //dipanggil di main untuk memantau perubahasn state
  await Hive.initFlutter();
  await init();
  //adapter harus di register sebelum box dibuka

  Bloc.observer = MyObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => appInjection<ProfileBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        // home: const AllUsersPage(),
        routerConfig: AppRoutes().router,
      ),
    );
  }
}
