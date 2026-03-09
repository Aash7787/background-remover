// import '../providers.dart';

// final appSettingsProvider = NotifierProvider<AppSettings, AppSettingsModel>(
//   AppSettings.new,
// );

// class AppSettings extends Notifier<AppSettingsModel> {
//   @override
//   AppSettingsModel build() {
//     final storedData = storageService.get(StorageConstants.appSettingsKey);

//     if (storedData != null) {
//       final jsonData = jsonDecode(storedData);
//       return AppSettingsModel.fromJson(jsonData);
//     }

//     return AppSettingsModel(
//       applocale: PlatformDispatcher.instance.locale,
//       themeMode: ThemeMode.system,
//     );
//   }

//   void changeAppThemeModel(AppSettingsModel theme) {
//     final data = state.copyWith(
//       applocale: theme.applocale,
//       themeMode: theme.themeMode,
//     );
//     _updateState(data);
//   }

//   void changeAppThemeMode(ThemeMode themeMode) {
//     final data = state.copyWith(themeMode: themeMode);
//     _updateState(data);
//   }

//   void changeAppLocale(Locale locale) {
//     final data = state.copyWith(applocale: locale);
//     _updateState(data);
//   }

//   void _updateState(AppSettingsModel newState) {
//     state = newState;
//     storageService.set(
//       StorageConstants.appSettingsKey,
//       jsonEncode(newState.toJson()),
//     );
//   }
// }
