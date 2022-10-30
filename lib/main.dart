import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/blocs/auth/auth_bloc.dart';
import 'domain/blocs/download_sync/download_sync_bloc.dart';
import 'domain/blocs/perfiles/perfiles_bloc.dart';
import 'domain/cubits/internet/internet_cubit.dart';

import 'domain/cubits/menu/menu_cubit.dart';
import 'injection.dart' as di;
import 'router.dart';
import 'ui/utils/styles.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => di.locator<InternetCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<AuthBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<DownloadSyncBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<MenuCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilesBloc>(),
          ),
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            initialRoute: AppRouter.initialRoute,
            routes: AppRouter.routes,
            theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch().copyWith(
                    primary: Styles.lightGreen,
                    secondary: Styles.obscureGreen))));
  }
}
