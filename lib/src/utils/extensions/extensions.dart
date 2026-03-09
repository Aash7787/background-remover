import '../utils.dart';

extension WidgetModifier on Widget {
  Widget padding([EdgeInsetsGeometry value = const EdgeInsets.all(16)]) {
    return Padding(padding: value, child: this);
  }

  Widget fixSize({double? width, double? height}) {
    return SizedBox(width: width, height: height, child: this);
  }

  Widget form({required GlobalKey<FormState> key}) {
    return Form(key: key, child: this);
  }

  Widget scroll([EdgeInsetsGeometry value = const EdgeInsets.all(0)]) {
    return SingleChildScrollView(padding: value, child: this);
  }

  Widget onInkTap({
    Function()? onTap,
    BorderRadius? borderRadius,
    Color? shadowColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      highlightColor: shadowColor,
      splashColor: shadowColor,
      child: this,
    );
  }

  Widget position({double? left, double? right, double? top, double? bottom}) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: this,
    );
  }

  Widget animate({
    Duration duration = const Duration(milliseconds: 400),
    required BuildContext context,
  }) {
    return AnimatedContainer(
      width: context.width,
      height: context.height,
      duration: duration,
      child: this,
    );
  }

  Widget verticalPadding({double padding = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: this,
    );
  }

  Widget horizontalPadding({double padding = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: this,
    );
  }

  Widget symmetricPadding({double vertical = 0, double horizontal = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  Widget dynamicPadding({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      ),
      child: this,
    );
  }

  Widget background(Color color) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color),
      child: this,
    );
  }

  Widget cornerRadius(BorderRadiusGeometry radius) {
    return ClipRRect(borderRadius: radius, child: this);
  }

  Widget circleWidget() {
    return ClipOval(child: this);
  }

  Widget align([AlignmentGeometry alignment = Alignment.center]) {
    return Align(alignment: alignment, child: this);
  }
}

extension DeviceWidth on BuildContext {
  double get width {
    return MediaQuery.sizeOf(this).width;
  }

  double get defHorizontalPad {
    return MediaQuery.sizeOf(this).width * 0.04;
  }

  double get systemTopPadding {
    return MediaQuery.of(this).padding.top;
  }

  double get height {
    return MediaQuery.sizeOf(this).height;
  }

  double get defVerticalPad {
    return MediaQuery.sizeOf(this).height * 0.02;
  }

  ThemeData get theme {
    return Theme.of(this);
  }

  bool get isArbicOrUrdu {
    return Directionality.of(this) == TextDirection.rtl;
  }

  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }

  Size get sizeOf {
    return MediaQuery.sizeOf(this);
  }

  TabBarThemeData get tabTheme {
    return Theme.of(this).tabBarTheme;
  }

  // AppLocalizations get appLocalizations {
  //   return AppLocalizations.of(this)!;
  // }

  bool get isDarkTheme => theme.brightness == Brightness.dark;

  bool get keyboardOpened => MediaQuery.of(this).viewInsets.bottom != 0;

  void onLoading() {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (BuildContext newcontext) {
        return SizedBox(
          height: height,
          width: width,
          child: const Center(child: CircularProgressIndicator.adaptive()),
        );
      },
    );
  }
}
