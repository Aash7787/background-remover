import '../ui.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  int _currentIndex = 0;

  PreferredSizeWidget? buildAppBar() {
    // final user = ref.watch(userProvider);

    if (_currentIndex == 0) {
      return AppBar(
        toolbarHeight: 75,
        title: Row(
          children: [
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  'Hey, Welcome to',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10),
                Text(
                  'Object Remover App',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // if (!user.isPremium) ...[
          // const ProBadge(),
          //   SizedBox(width: context.defHorizontalPad),
          // ],
        ],
      );
    }

    if (_currentIndex == 1) {
      return AppBar(title: Text("History"));
    }

    if (_currentIndex == 2) {
      return AppBar(title: Text("Settings"));
    }

    return null;
  }

  final List<Widget> screens = [
    const HomeScreen(),
    const HistoryScreen(),
    const SettingScreen(),
  ];
  void changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        showExitDialog(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: buildAppBar(),
        bottomNavigationBar: CustomBottomNavBar(
          index: _currentIndex,
          onTap: changeIndex,
          onActionTap: () {},
        ),
        body: screens[_currentIndex],
      ),
    );
  }
}
