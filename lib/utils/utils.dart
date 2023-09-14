
class Utils{

  static String formatNumber(int? number) {
    if (number == null) {
      return 'N/A';
    }

    if (number >= 1e6) {
      double million = number / 1e6;
      return '${million.toStringAsFixed(2)} M';
    } else if (number >= 1e3) {
      double thousand = number / 1e3;
      return '${thousand.toStringAsFixed(2)} K';
    } else {
      return number.toString();
    }
  }
}