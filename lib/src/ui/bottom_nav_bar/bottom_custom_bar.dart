import '../ui.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTap;
  final VoidCallback onActionTap;

  const CustomBottomNavBar({
    super.key,
    required this.index,
    required this.onTap,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.defHorizontalPad * 4.5,
        vertical: context.defVerticalPad,
      ),
      child: Row(
        children: [
          /// PILL
          Expanded(
            child: Container(
              height: 60,
              padding: EdgeInsets.all(6),
              decoration: ContainerDecoration(
                radius: 50,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.08),
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BottomNavItem(
                    selected: index == 0,
                    icon: AppIcons.home,
                    label: "Home",
                    onTap: () => onTap(0),
                  ),

                  BottomNavItem(
                    selected: index == 1,
                    icon: AppIcons.history,
                    label: "History",
                    onTap: () => onTap(1),
                  ),

                  BottomNavItem(
                    selected: index == 2,
                    icon: AppIcons.setting,
                    label: "Settings",
                    onTap: () => onTap(2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

