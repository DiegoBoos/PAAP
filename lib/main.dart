import 'package:flutter/material.dart';
import 'package:paap/modules/auth/services/auth.service.dart';
import 'package:paap/router/app_routes.dart';
import 'package:paap/utils/notifications.service.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.routes,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        navigatorKey: NotificationService.navigatorKey,
        scaffoldMessengerKey: NotificationService.messengerKey,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[300],
            colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: const Color(0xFF50C3F7),
                secondary: const Color(0xFF2963FF))));
  }
}
