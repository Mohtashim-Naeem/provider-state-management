import 'package:flutter/material.dart';
import 'package:form_app_ssp/screens/login_screen.dart';
import 'package:provider/provider.dart';

import './services/navigation_service.dart';
import './utils/service_locator.dart';
import './utils/routes.dart';
import 'providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // final devicePreview = DevicePreview.appBuilder;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Form App',
        color: Theme.of(context).colorScheme.background,
        debugShowCheckedModeBanner: false,
        // builder: DevicePreview.appBuilder,
        navigatorKey: locator<NavigationService>().navigatorKey,
        theme: ThemeData(
          primaryColor: Colors.blue[900],
          // primarySwatch: Colors.green[600],

          visualDensity: VisualDensity.adaptivePlatformDensity,
          // Define the default font family.
          // fontFamily: 'Oxygen',
        ),
        // home: const LoginScreen(),

        onGenerateRoute: onGenerateRoute,
        initialRoute: splashScreenRoute,
      ),
    );
  }
}
