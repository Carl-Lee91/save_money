import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:save_money/public_method/public_method.dart';
import 'package:save_money/router/router.dart';
import 'package:save_money/theme/app_dark_theme.dart';
import 'package:save_money/theme/app_light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PublicMethod.preferenceinit();

  PublicMethod.secureStorageInit();

  await dotenv.load(fileName: '.env');

  KakaoSdk.init(nativeAppKey: dotenv.get('KAKAO_API_KEY').toString());

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppLightTheme.appLightTheme,
      darkTheme: AppDarkTheme.appDarkTheme,
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
    );
  }
}
