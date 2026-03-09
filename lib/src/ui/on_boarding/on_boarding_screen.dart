import '../ui.dart';

class OnBoardingScreen extends ConsumerStatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnBoardingScreenState();
}

class _OnBoardingScreenState extends ConsumerState<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
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
                  Image.asset("assets/images/boarding01.png"),

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
                          Text(
                            "Remove Objects &\nBackgrounds Instantly",
                            textAlign: TextAlign.center,
                            style: context.textTheme.titleLarge!.copyWith(
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontSize: 34,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: context.defVerticalPad),
                          Text(
                            textAlign: TextAlign.center,
                            softWrap: true,
                            'Erase unwanted people, text, or items and remove backgrounds with one tap using smart AI detection.',
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: Color(0xFF909792),
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              height: 2.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 56,
                              width: 200,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    Colors.black,
                                  ),
                                ),
                                onPressed: () {},
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
