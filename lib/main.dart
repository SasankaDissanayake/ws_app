import 'package:app/firebase_options.dart';
import 'package:app/source/authentication/controllers/authentication_repository.dart';
import 'package:app/source/references/translation_references.dart';
import 'package:app/source/splash_screen/screens/loading_screen_widget.dart';
import 'package:app/source/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));

  runApp(const WeddingStage());
}

class WeddingStage extends StatelessWidget {
  const WeddingStage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wedding Stage',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      translations: AppTranslations(),
      locale: const Locale('en', 'US'),
      home: const LoadingScreen(),
    );
  }
}
