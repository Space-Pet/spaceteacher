// class Allocation {
//   final int? pk;
//   final String code;
//   final String listPartsInCell;
//   final int? shelved;
//   final int? status;
//
//   Allocation({
//     required this.pk,
//     required this.code,
//     required this.listPartsInCell,
//     required this.shelved,
//     required this.status
//   });
//
//   factory Allocation.fromMap(Map<String, dynamic> map) {
//     final pk = map['pk'];
//     final code = map['code'] ?? '';
//     final listPartsInCell = map['list_parts_in_cell'] ?? '';
//     final shelved = map['shelved'];
//     final status = map['status'];
//     return Allocation(
//       pk: pk,
//       code: code,
//       listPartsInCell: listPartsInCell,
//       status: status,
//       shelved: shelved,
//     );
//   }
// }

class CellStock {
  final String pk;
  // final List<Allocation> allocations;
  final String code;

  CellStock({
    required this.pk,
    // required this.allocations,
    required this.code,
  });

  factory CellStock.fromMap(Map<String, dynamic> map) {
    final pk = map['pk']?.toString() ?? '';
    final allocationsList = map['allocations'] as List<dynamic>?;
    final code = map['code'] ?? '';
    // final List<Allocation> allocations = [];

    // if (allocationsList != null) {
    //   for (final allocationMap in allocationsList) {
    //     final allocation = Allocation.fromMap(allocationMap);
    //     allocations.add(allocation);
    //   }
    // }

    return CellStock(
      pk: pk,
      code: code,
      // allocations: allocations,
    );
  }
}
