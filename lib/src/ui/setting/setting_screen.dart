import '../ui.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: context.defHorizontalPad,
        vertical: context.defVerticalPad,
      ),
      children: [
        _SettingGroup(
          children: [
            _SettingItem(
              icon: AppIcons.rate,
              title: "Pricing",
              onTap: () {
                launchUrl(
                  Uri.parse(AppConstants.appLink),
                  mode: LaunchMode.externalApplication,
                ).ignore();
              },
            ),
            Builder(
              builder: (context) {
                return _SettingItem(
                  icon: AppIcons.shareApp,
                  title: "Rate us",
                  onTap: () {
                    final box = context.findRenderObject() as RenderBox?;
                    SharePlus.instance.share(
                      ShareParams(
                        text:
                            "Check out ${AppConstants.appName}:\n${AppConstants.appLink}",
                        sharePositionOrigin: box != null
                            ? (box.localToGlobal(Offset.zero) & box.size)
                            : null,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),

        SizedBox(height: context.defVerticalPad),

        _SettingGroup(
          children: [
            _SettingItem(
              icon: AppIcons.contact,
              title: "Share App",
              onTap: () async {
                final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: AppConstants.contactMail,
                  query: Uri.encodeFull('subject=Support Request'),
                );

                if (!await launchUrl(emailUri)) {
                  throw Exception('Could not launch email client');
                }
              },
            ),
            _SettingItem(
              icon: AppIcons.terms,
              title: "Contact us",
              onTap: () {
                launchUrl(
                  Uri.parse(AppConstants.terms),
                  mode: LaunchMode.externalApplication,
                ).ignore();
              },
            ),
            _SettingItem(
              icon: AppIcons.privacy,
              title: "Terms of services",
              onTap: () {
                launchUrl(
                  Uri.parse(AppConstants.privacyPolicy),
                  mode: LaunchMode.externalApplication,
                ).ignore();
              },
            ),

            _SettingItem(
              icon: AppIcons.privacy,
              title: "Privacy Policy",
              onTap: () {
                launchUrl(
                  Uri.parse(AppConstants.privacyPolicy),
                  mode: LaunchMode.externalApplication,
                ).ignore();
              },
            ),
          ],
        ),

        SizedBox(height: context.defVerticalPad),

        _SettingGroup(
          children: [
            _SettingItem(
              icon: AppIcons.privacy,
              title: "Exit app",
              onTap: () {
                launchUrl(
                  Uri.parse(AppConstants.privacyPolicy),
                  mode: LaunchMode.externalApplication,
                ).ignore();
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _SettingGroup extends StatelessWidget {
  final List<Widget> children;

  const _SettingGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ContainerDecoration(
        color: const Color(0xFFEEF0FA),
        borderColor: const Color(0xFFEEF0FA),
        radius: 16,
      ),
      child: Column(
        children: List.generate(children.length, (index) {
          return Column(
            children: [
              children[index],
              if (index != children.length - 1)
                Padding(
                  padding: const EdgeInsets.only(right: 18, left: 18),
                  child: const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFDDE1F3),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback? onTap;

  const _SettingItem({required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:
          Row(
            children: [
              SvgPicture.string(icon),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  title,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              const Icon(Icons.chevron_right, color: AppColors.placeholder),
            ],
          ).dynamicPadding(
            left: context.defHorizontalPad,
            right: context.defHorizontalPad,
            top: context.defVerticalPad,
            bottom: context.defVerticalPad,
          ),
    );
  }
}
