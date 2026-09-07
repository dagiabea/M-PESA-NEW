class MoneyFormatter {
  MoneyFormatter._();

  static String format(double value) {
    final fixed = value.toStringAsFixed(2);
    final split = fixed.split('.');
    final whole = split[0];
    final buffer = StringBuffer();
    for (var i = 0; i < whole.length; i++) {
      if (i > 0 && (whole.length - i) % 3 == 0) buffer.write(',');
      buffer.write(whole[i]);
    }
    return '${buffer.toString()}.${split[1]}';
  }
}
