import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/blocs/auth/auth_bloc.dart';

import 'package:paap/router.dart';
import 'package:paap/ui/utils/background_colors.dart';

import 'domain/blocs/perfiles/perfiles_bloc.dart';
import 'domain/cubits/internet/internet_cubit.dart';
import 'domain/blocs/menu/menu_bloc.dart';
import 'injection.dart' as di;

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
            create: (_) => di.locator<MenuBloc>(),
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
                    primary: TabsUtils.lightGreen,
                    secondary: TabsUtils.obscureGreen))));
  }
}
