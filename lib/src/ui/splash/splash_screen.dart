import '../ui.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    final bool showOnboard =
        await storageService.get(StorageConstants.isShowOnboard) ?? true;

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    if (showOnboard) {
      RouteNavigator.replaceAll(const OnBoardingScreen());
    } else {
      RouteNavigator.replaceAll(const BottomNavBar());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD6EBFF), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            height: context.height,
            width: context.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/splash.png", width: 120),

                SizedBox(height: context.defVerticalPad),

                Text(
                  "Background\nRemover",
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleLarge!.copyWith(
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: context.defVerticalPad * 0.6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
