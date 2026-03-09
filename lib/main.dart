import 'app.dart';

late final StorageService storageService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  storageService = HiveService();
  await storageService.init();

  runApp(const MainApp());
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // final appSettingsState = ref.watch(appSettingsProvider);
    return MaterialApp(
      navigatorKey: RouteNavigator.navigationKey,
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      themeMode: ThemeMode.light,
      // locale: appSettingsState.applocale,
      home: const SplashScreen(),
    );
  }
}
