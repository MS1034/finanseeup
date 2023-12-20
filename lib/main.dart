import 'package:finanseeup/bindings/general_bindings.dart';
import 'package:finanseeup/firebase_options.dart';
import 'package:finanseeup/routes.dart';
import 'package:finanseeup/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:workmanager/workmanager.dart';

import 'data/repositories/authentication_repository.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // await AccountRepository.instance.synchronizeCloudWithLocal();
    print("yes I ams in");
    return Future.value(true);
  });
}

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    Get.put(AuthenticationRepository());
  });

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );

  Workmanager().registerPeriodicTask(
    'updateAccountsTask',
    'updateAccountsTask',
    frequency: const Duration(minutes: 15),
  );

  final myAppLifecycleObserver = MyAppLifecycleObserver();
  WidgetsBinding.instance.addObserver(myAppLifecycleObserver);
  // FirebaseDatabase.instance.setPersistenceEnabled(true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Finansee Up',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      // home: const HomeView(title: "Home",),
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

class MyAppLifecycleObserver with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      onAppExit();
    }
  }

  Future<void> onAppExit() async {
    // await AccountRepository.instance.synchronizeCloudWithLocal();

    // Perform any necessary cleanup or final sync
  }
}
