class DemoSession {
  DemoSession._();

  static String userName = 'Samuel';

  static void setUserName(String value) {
    final String cleanName = value.trim();

    userName = cleanName.isEmpty ? 'Explorador' : cleanName;
  }
}
