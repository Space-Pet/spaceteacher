import 'package:intl/intl.dart';

class BarcodeInfo {
  final int? status;
  final String barcode;
  final int? pk;
  final DateTime timeScan;
  final String? cellDetail;
  final String statusText;
  BarcodeInfo(
      {required this.status,
      required this.barcode,
      required this.pk,
      required this.timeScan,
      required this.cellDetail,
      required this.statusText});

  factory BarcodeInfo.fromMap(Map<String, dynamic> map) {
    final cell = map['cell_detail'];
    final cellDetail = cell != null ? cell['code'] ?? '' : '';
    return BarcodeInfo(
        barcode: map['barcode'] ?? '',
        statusText: map['status_text'] ?? '',
        status: map['status'] != null
            ? int.tryParse(map['status'].toString())
            : null,
        pk: map['pk'] != null ? int.tryParse(map['pk'].toString()) : null,
        cellDetail: cellDetail,
        timeScan: DateFormat('HH:mm:ss dd/MM/yyyy').parse(map['time_scan']));
  }
}
