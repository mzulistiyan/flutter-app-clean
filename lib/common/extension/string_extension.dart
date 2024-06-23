import 'package:intl/intl.dart';

extension StringExtension on String? {
  String get fullDateDMMMMY {
    return DateFormat('d MMMM y', 'id_ID').format(
      this != null ? DateTime.parse(this!) : DateTime.now(),
    );
  }
}

extension RupiahFormat on String {
  String toRupiah() {
    final formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);
    final int number = int.tryParse(replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    return formatter.format(number);
  }
}
