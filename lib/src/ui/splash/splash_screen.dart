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

    // Future.microtask(() {
    //   ref.read(subscriptionProvider.notifier).onInit();
    // });

    if (mounted) {
      RouteNavigator.replaceAll(
        showOnboard ? const OnBoardingScreen() : const BottomNavBar(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3A7CFF), Color(0xFF2A62D1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            height: context.height,
            width: context.width,
            child: Column(
              children: [
                const Spacer(),

                Image.asset("assets/images/splash.png", width: 120),

                SizedBox(height: context.defVerticalPad),

                Text(
                  "AI Grammar Checker",
                  style: context.textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
                ),

                const Spacer(),

                /// LOADING BAR
                const _SplashLoadingBar(),

                SizedBox(height: context.defVerticalPad * 0.6),

                /// LOADING TEXT
                Text(
                  "Loading...",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),

                SizedBox(height: context.defVerticalPad * 1.2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _SplashLoadingBar extends StatefulWidget {
  const _SplashLoadingBar();

  @override
  State<_SplashLoadingBar> createState() => _SplashLoadingBarState();
}

class _SplashLoadingBarState extends State<_SplashLoadingBar>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalWidth = context.width * 0.65;

    return Container(
      width: totalWidth,
      height: 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withValues(alpha: 0.25),
      ),
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: totalWidth * controller.value,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}

