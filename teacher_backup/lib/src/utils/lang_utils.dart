class LangUtils {
  static String getLangCodeCountryFlag(String lang) {
    switch (lang) {
      case 'en':
        return 'us';
      case 'vi':
        return 'vn';
      default:
        return 'us';
    }
  }

  static String getLangName(String lang) {
    switch (lang) {
      case 'en':
        return 'English';
      case 'vi':
        return 'Vietnamese';
      default:
        return 'English';
    }
  }

  static getCountryCode(String lang) {
    switch (lang) {
      case 'en':
        return 'US';
      case 'vi':
        return 'VN';
      default:
        return 'US';
    }
  }
}
