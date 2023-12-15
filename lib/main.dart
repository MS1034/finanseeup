import 'package:finanseeup/bindings/general_bindings.dart';
import 'package:finanseeup/firebase_options.dart';
import 'package:finanseeup/utils/theme.dart';
import 'package:finanseeup/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'data/repositories/authentication_repository.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    Get.put(AuthenticationRepository());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceStorage = GetStorage();

    return GetMaterialApp(
      title: 'Finansee Up',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      getPages: [
        GetPage(
            name: '/',
            page: () {
              return AppRoutes.redirectRoute();
            })
      ],
      initialBinding: GeneralBindings(),
      themeMode: ThemeMode.system,
    );
  }
}
