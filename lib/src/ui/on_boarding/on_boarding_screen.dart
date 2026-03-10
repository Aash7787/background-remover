import '../ui.dart';

class OnBoardingScreen extends ConsumerStatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnBoardingScreenState();
}

class _OnBoardingScreenState extends ConsumerState<OnBoardingScreen> {
  int currentIndex = 0;

  final List<_OnboardModel> pages = const [
    _OnboardModel(
      image: 'assets/images/boarding01.png',
      title: 'Remove Objects &\nBackgrounds Instantly',
      desc:
          'Erase unwanted people, text, or items and remove backgrounds with one tap using smart AI detection.',
    ),
    _OnboardModel(
      image: 'assets/images/boarding02.png',
      title: 'Enhance & Upscale to HD Quality',
      desc:
          'Improve sharpness, boost details, and upscale your images to high resolution without losing quality.',
    ),
  ];

  void _next() {
    if (currentIndex == pages.length - 1) {
      storageService.set(StorageConstants.isShowOnboard, false);
      RouteNavigator.replaceAll(BottomNavBar());
    } else {
      setState(() {
        currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = pages[currentIndex];

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD6EBFF), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SafeArea(
            child: SizedBox(
              height: context.height,
              width: context.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: context.defVerticalPad * 3.5),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                    child: Image.asset(
                      currentPage.image,
                      key: ValueKey(currentPage.image),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(pages.length, (index) {
                      final bool isActive = currentIndex == index;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 10,
                        width: isActive ? 20 : 10,
                        decoration: BoxDecoration(
                          color: isActive
                              ? const Color(0xFF3F9FFF)
                              : const Color(0xFFD7E8F7),
                          borderRadius: BorderRadius.circular(99),
                        ),
                      );
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 32,
                      bottom: 48,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: context.defVerticalPad * 1.5),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: SlideTransition(
                                      position:
                                          Tween<Offset>(
                                            begin: const Offset(0.1, 0),
                                            end: Offset.zero,
                                          ).animate(
                                            CurvedAnimation(
                                              parent: animation,
                                              curve: Curves.easeOutCubic,
                                            ),
                                          ),
                                      child: child,
                                    ),
                                  );
                                },
                            child: Text(
                              currentPage.title,
                              key: ValueKey(currentPage.title),
                              textAlign: TextAlign.center,
                              style: context.textTheme.titleLarge!.copyWith(
                                fontSize: 34,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(height: context.defVerticalPad),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: SlideTransition(
                                      position:
                                          Tween<Offset>(
                                            begin: const Offset(0.1, 0),
                                            end: Offset.zero,
                                          ).animate(
                                            CurvedAnimation(
                                              parent: animation,
                                              curve: Curves.easeOutCubic,
                                            ),
                                          ),
                                      child: child,
                                    ),
                                  );
                                },
                            child: Text(
                              currentPage.desc,
                              key: ValueKey(currentPage.desc),
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodyMedium!.copyWith(
                                color: AppColors.placeholder,
                                fontSize: 16,
                                height: 2,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(height: context.defVerticalPad * 4.5),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 56,
                              width: 200,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  backgroundColor: WidgetStatePropertyAll(
                                    Colors.black,
                                  ),
                                ),
                                onPressed: _next,
                                child: Text(
                                  'Next',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OnboardModel {
  final String image;
  final String title;
  final String desc;

  const _OnboardModel({
    required this.image,
    required this.title,
    required this.desc,
  });
}
