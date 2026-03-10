import '../ui.dart';

class ExitAppDialog extends StatelessWidget {
  const ExitAppDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: ContainerDecoration(
          radius: 18,
          borderColor: AppColors.cardBorder,
          color: AppColors.white,
        ),
        padding: EdgeInsets.all(16),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            /// Close button
            Positioned(
              right: -5,
              top: -5,
              child: GestureDetector(
                onTap: () => RouteNavigator.back(),
                child: const Icon(
                  Icons.close,
                  size: 20,
                  color: AppColors.placeholder,
                ),
              ),
            ),

            /// Content
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: context.defVerticalPad * 0.4),

                /// Title
                Text(
                  "Exit App!",
                  style: context.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: context.defVerticalPad * 0.5),

                /// Description
                Text(
                  "Are you sure you want to exit app!",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.placeholder,
                  ),
                ),

                SizedBox(height: context.defVerticalPad * 1.4),

                /// Buttons
                Row(
                  children: [
                    /// No Button
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: const BorderSide(color: AppColors.cardBorder),
                        ),
                        onPressed: () => RouteNavigator.back(),
                        child: const Text(
                          "No",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    /// Yes Exit Button
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F3036),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        child: const Text(
                          "Yes, exit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showExitDialog(BuildContext context) {
  showDialog(context: context, builder: (_) => const ExitAppDialog());
}
