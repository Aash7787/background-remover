import '../utils.dart';

class AppTheme {
  AppTheme._();
  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      cardColor: AppColors.outline,
      brightness: Brightness.light,
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 16,
          color: AppColors.textColor,
          fontWeight: FontWeight.w500,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        focusColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8.0,
        ),
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.placeholder,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(width: 1, color: AppColors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(width: 1, color: AppColors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(width: 1, color: AppColors.white),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(),
        headlineMedium: TextStyle(),
        headlineSmall: TextStyle(),
        displayLarge: TextStyle(),
        displayMedium: TextStyle(),
        displaySmall: TextStyle(),
        labelLarge: TextStyle(),
        labelMedium: TextStyle(),
        labelSmall: TextStyle(),
        titleLarge: TextStyle(),
        titleMedium: TextStyle(),
        titleSmall: TextStyle(),
        bodyLarge: TextStyle(),
        bodyMedium: TextStyle(),
        bodySmall: TextStyle(),
      ).apply(bodyColor: AppColors.heading, displayColor: AppColors.heading),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: WidgetStateProperty.resolveWith<double>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.pressed)) {
              return 6.0;
            } else {
              return 0;
            }
          }),
          fixedSize: WidgetStateProperty.all<Size>(const Size.fromHeight(45)),
          textStyle: WidgetStateProperty.all<TextStyle>(
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(AppColors.primary),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.outline),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData();
  }
}
