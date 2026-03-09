import '../utils.dart';

enum Filter { all, recent, week, month, year }

enum SelectFileType { pdf, word, text }

enum CorrectionType {
  grammar,
  spelling,
  punctuation;

  Color get color => AppColors.red;
}

enum Tooltype { tools }

class AppConstants {
  AppConstants._();
  static const String appName = "Grammer Checker";

  static const String contactMail = "appsstudio626@gmail.com";
  static const String privacyPolicy =
      "https://www.freeprivacypolicy.com/live/397f5787-d7f1-45d0-a851-deb630be54ec";
  static const String terms =
      "https://appsglobalstudio.blogspot.com/2024/07/terms-of-use.html?m=1";
  static const String appLink =
      "https://apps.apple.com/us/app/ai-grammar-checker/id6760130507";
  static const String store =
      "https://apps.apple.com/us/developer/amina-sehar/id1823051162";
}
