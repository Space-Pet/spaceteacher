import 'dart:io';

import 'package:flutter/material.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:utils/utils.dart';

enum ActiveStatus { created, processing, done, none }

enum StatusTicket { created, processing, done, none }

enum StatusWarehouse { created, processing, done, none }

enum Type { hireWorker, line, po, so, delete, liquidation, none }

extension TypeColorEx on Type {
  Color get typeColor {
    switch (this) {
      case Type.delete:
        return ColorsResource.redSecondary;
      case Type.liquidation:
        return ColorsResource.green;
      case Type.po:
        return ColorsResource.bluebotton;
      case Type.so:
        return Colors.amber;
      case Type.line:
        return ColorsResource.FF7E13;
      case Type.hireWorker:
        return ColorsResource.lightGray50;
      case Type.none:
        return ColorsResource.lightGray50;
    }
  }
}

extension ActiveStatusExtension on ActiveStatus {
  String get name {
    switch (this) {
      case ActiveStatus.created:
        return 'Phiếu mới tạo';
      case ActiveStatus.processing:
        return 'Đang xử lí';
      case ActiveStatus.done:
        return 'Hoàn thành';
      default:
        return 'Không xác định';
    }
  }

  Color get statusColor {
    switch (this) {
      case ActiveStatus.created:
        return ColorsResource.primary;
      case ActiveStatus.processing:
        return ColorsResource.primary;
      case ActiveStatus.done:
        return ColorsResource.green;
      default:
        return ColorsResource.lightGray50;
    }
  }
}

extension StatusStockEx on StatusWarehouse {
  String get name {
    switch (this) {
      case StatusWarehouse.created:
        return 'Phiếu mới tạo';
      case StatusWarehouse.processing:
        return 'Đang xử lí';
      case StatusWarehouse.done:
        return 'Hoàn thành';
      default:
        return 'Không xác định';
    }
  }

  Color get statusColor {
    switch (this) {
      case StatusWarehouse.created:
        return ColorsResource.primary;
      case StatusWarehouse.processing:
        return ColorsResource.primary;
      case StatusWarehouse.done:
        return ColorsResource.green;
      default:
        return ColorsResource.lightGray50;
    }
  }
}

extension StatusExtension on StatusTicket {
  String get name {
    switch (this) {
      case StatusTicket.created:
        return 'Phiếu mới tạo';
      case StatusTicket.processing:
        return 'Đang xử lí';
      case StatusTicket.done:
        return 'Hoàn thành';
      default:
        return 'Không xác định';
    }
  }

  Color get statusColor {
    switch (this) {
      case StatusTicket.created:
        return ColorsResource.primary;
      case StatusTicket.processing:
        return ColorsResource.primary;
      case StatusTicket.done:
        return ColorsResource.green;
      default:
        return ColorsResource.lightGray50;
    }
  }
}

extension TypeExtension on RequestData {
  Type get type {
    switch (strType) {
      case 'Mua thùng rỗng':
        return Type.line;
      case 'Thuê nhân công':
        return Type.hireWorker;
      case 'Xuất trả':
        return Type.so;
      case 'Thanh lý':
        return Type.liquidation;
      case 'Tiêu huỷ':
        return Type.delete;
      case 'Nhập trả':
        return Type.po;
      case 'Lưu trữ':
        return Type.po;
      default:
        return Type.none;
    }
  }

  bool get isLine => type == Type.line;
  bool get isHireWorker => type == Type.hireWorker;
  bool get isPO => type == Type.po;
  bool get isSO => type == Type.so;
  bool get isDele => type == Type.delete;
  bool get isLiqui => type == Type.liquidation;
}

extension RequestDataExtension on RequestData {
  ActiveStatus get active {
    switch (intActive) {
      case 1:
        return ActiveStatus.created;
      case 2:
        return ActiveStatus.processing;
      case 3:
        return ActiveStatus.done;
      default:
        return ActiveStatus.none;
    }
  }
}

extension StocktakingDataEx on Stocktaking {
  StatusWarehouse get status {
    switch (intStatus) {
      case 10:
        return StatusWarehouse.created;
      case 20:
        return StatusWarehouse.processing;
      case 30:
        return StatusWarehouse.done;
      default:
        return StatusWarehouse.none;
    }
  }
}

extension TicketRequestDataExtension on TicketDeclaration {
  StatusTicket get status {
    switch (intStatus) {
      case 10:
        return StatusTicket.created;
      case 20:
        return StatusTicket.processing;
      case 30:
        return StatusTicket.done;
      default:
        return StatusTicket.none;
    }
  }
}

class JobRepository {
  JobRepository({required JobApi jobApi}) : _jobApi = jobApi;
  final JobApi _jobApi;
  Future<String?> initApp() async {
    final token = await _jobApi.getToken();
    return token;
  }

  Future<String?> postShare(
      {required List<Map<String, Object>> data, required int pk}) async {
    final link = await _jobApi.postShare(data: data, pk: pk);
    return link;
  }

  Future<void> postListBarcodeOptional(
      {required int? pk, required List<Map<String, Object>>? data}) async {
    await _jobApi.postListBarcodeOptional(pk: pk, data: data);
  }

  Future<int?> postListBarcode(
      {required int? pk,
      required int pkStockPO,
      required List<Map<String, Object>>? data,
      required String? type}) async {
    final statusCode = await _jobApi.postListBarcode(pk: pk, data: data, type: type, pkStockPO: pkStockPO);
    return statusCode;
  }

  Future<List<BarcodeInfo>> getBarcode({required int pk}) async {
    try {
      final data = await _jobApi.getBarcode(pk: pk);
      return data;
    } catch (e) {
      return [];
    }
  }
  Future<void> complatedTicketPO ({required List pk})async{
    await _jobApi.complatedTicketPO(pk: pk);
  }
  Future<void> postCreatePo({required Map<String, Object?> data}) async {
    await _jobApi.postCreatePo(data: data);
  }

  Future<List<BarcodeDeclaration>> getBarcodeDeclaration(
      {required int pk}) async {
    final data = await _jobApi.getBarcodeDeclaration(pk: pk);
    return data;
  }

  Future<List<BarcodeDeclaration>> getBarcodeStocktaking(
      {required int pk}) async {
    final data = await _jobApi.getBarcodeStocktaking(pk: pk);
    return data;
  }

  Future<int?> postBarcodeStocktaking(
      {required int pk, required List<Map<String, Object>> data}) async {
   final statusCode = await _jobApi.postBarcodeStocktaking(pk: pk, data: data);
   return statusCode;
  }

  Future<List<StockInventory>> getStockInventory() async {
    final data = await _jobApi.getStockInventory();
    return data;
  }
  Future<void> complatedStep({required int pk, required String pkStockSO})async{
    await _jobApi.complatedStep(pk: pk, pkStockSO: pkStockSO);
  }
  Future<List<BarcodeInfo>> postBarcode(String? cardType, int? pk,
      {required String barcode,
      required int? status,
      required String lastUpdated}) async {
    try {
      final postBarcodeInfo = await _jobApi.postBarcodeList(
        pk,
        cardType!,
        barcode: barcode,
        status: status,
        lastUpdated: lastUpdated,
      );
      return postBarcodeInfo;
    } catch (e) {
      return [];
    }
  }

  Future<int?> postBarcodeDeclaration(
      {required int type,
      required int pk,
      required List<Map<String, Object>>? data}) async {
    final statusCode = await _jobApi.postBarcodeDeclaration(type: type, pk: pk, data: data);
    return statusCode;
  }

  Future<List<BarcodeInfo>> barcode(String? cardType, int? pk, int page) async {
    try {
      final barcodeRepo =
          await _jobApi.getBarcodeListForJob(pk, cardType, page);
      return barcodeRepo;
    } catch (e) {
      return [];
    }
  }

  Future<NumberStep> getNumberStep(int pk, String cardType) async {
    try {
      final numberStep = await _jobApi.getNumberStep(pk, cardType);
      return numberStep;
    } catch (e) {
      throw GetJobListFailure();
    }
  }

  Future<NumberStepInventory> getNumberStepInventory(
      int pk, String cardType, String stock) async {
    try {
      final numberStepInventory =
          await _jobApi.getNumberStepInventory(pk, cardType, stock);
      return numberStepInventory;
    } catch (e) {
      throw GetJobListFailure();
    }
  }

  Future<List<BarcodeInfo>> barcodeKK(String? cardType, int? pk) async {
    try {
      final barcodeRepo = await _jobApi.getBarcodeListForJobKK(pk, cardType);
      return barcodeRepo;
    } catch (e) {
      return [];
    }
  }

  Future<List<NotificationInfo>> getNotification() async {
    try {
      final notificationsData = await _jobApi.getNotification();
      return notificationsData;
    } catch (e) {
      return [];
    }
  }

  Future<List<GetListUser>> getListUser() async {
    try {
      final getListUser = await _jobApi.getListUser();
      return getListUser;
    } catch (e) {
      return [];
    }
  }

  Future<List<GetListUser>> getListUserTK() async {
    try {
      final getListUser = await _jobApi.getListUserTK();
      return getListUser;
    } catch (e) {
      return [];
    }
  }

  Future<List<FaqInfo>> getFaq(String search) async {
    try {
      final getListFaq = await _jobApi.getFaq(search);
      return getListFaq;
    } catch (e) {
      return [];
    }
  }

  Future<void> postAssignPo(String po, String user) async {
    await _jobApi.postAssignPO(po, user);
  }

  Future<void> postAssignSo(String so, String user) async {
    await _jobApi.postAssignSO(so, user);
  }

  Future<void> postAssignKK(String kk, String user) async {
    await _jobApi.postAssignKK(kk, user);
  }

  Future<List<StockInfo>> getStockInfo() async {
    try {
      final stockInfo = await _jobApi.getStockerInfo();
      return stockInfo;
    } catch (e) {
      return [];
    }
  }

  Future<List<Stocktaking>> getStocktaking({required int pk}) async {
    final data = await _jobApi.getStocktaking(pk: pk);
    return data;
  }

  Future<void> putUnread({required String id}) async {
    await _jobApi.putUnread(id: id);
  }

  Future<void> postBoxDataList({
    required String barcode,
    required String cellId,
    required int? status,
    required int pk,
  }) async {
    try {
      await _jobApi.postBoxDataList(
          barcode: barcode, cellId: cellId, status: status, pk: pk);
    } catch (e) {}
  }

  Future<void> putBoxDataListKK(int pk, String cardType,
      {required String barcode,
      required String cellId,
      required int status}) async {
    try {
      await _jobApi.putBoxDataListKK(pk, cardType,
          barcode: barcode, cellId: cellId, status: status);
    } catch (e) {}
  }

  Future<void> postRemoveBoxDataList(
      {required String barcode,
      required String cellId,
      required int pk,
      required int? status}) async {
    await _jobApi.postRemoveBoxDataList(
        barcode: barcode, cellId: cellId, status: status, pk: pk);
  }

  Future<List<CellStock>> getCellStockList(int? stockId) async {
    try {
      final cellStock = await _jobApi.getCellStock(stockId);
      return cellStock;
    } catch (e) {
      throw GetCellStockFailure();
    }
  }

  Future<List<StockInfo>> getStockInfoId(int? stockId) async {
    try {
      final stockInfo = await _jobApi.getStockerInfoId(stockId);
      return stockInfo;
    } catch (e) {
      return [];
    }
  }

  Future<List<RequestInfo>> getRequestTicket(
      {required String page,
      String? active,
      String? startDate,
      String? endDate,
      String? search}) async {
    try {
      final requestList = await _jobApi.getRequestTicket(
          page: page,
          active: active,
          startDate: startDate,
          endDate: endDate,
          search: search);
      return requestList;
    } catch (e) {
      throw GetJobListFailure();
    }
  }

  Future<List<EmptyBox>> getLines({required int pk}) async {
    final emptyBox = await _jobApi.getLines(pk: pk);
    return emptyBox;
  }
  Future<List<StatusLine>> getStatusLine({required int pk})async{
    final data = await _jobApi.getStatusLine(pk: pk);
    return data;
  }

  Future<int?> putLines(
      {required int pk, required List<Map<String, Object>> data}) async {
    final lines = await _jobApi.putLines(pk: pk, data: data);
    return lines;
  }

  Future<List<JobListInfo>> getUserJobLisNotReceived({
    required String page,
    required String endDate,
    required String status,
    required String startDate,
    required String search,
  }) async {
    try {
      final jobList = await _jobApi.getJobListNotReceived(
          page, startDate, endDate, status, search);
      return jobList;
    } catch (e) {
      throw GetJobListFailure();
    }
  }

  Future<List<TicketDeclaration>> getTicketDecration({
    required String endDate,
    required String status,
    required String startDate,
    required String search,
  }) async {
    try {
      final jobList = await _jobApi.getTicketDeclaration(
          startDate, endDate, status, search);
      return jobList;
    } catch (e) {
      throw GetJobListFailure();
    }
  }

  Future<List<JobListInfo>> getUserJobLisNotReceivedStock({
    required String page,
    required String endDate,
    required String status,
    required String startDate,
    required String search,
    required String stock,
  }) async {
    try {
      final jobList = await _jobApi.getJobListNotReceivedStock(
          page, startDate, endDate, status, search, stock);
      return jobList;
    } catch (e) {
      throw GetJobListFailure();
    }
  }

  Future<List<JobListInfo>> getUserJobLisStock(
      String page, String stock) async {
    try {
      final jobList = await _jobApi.getJobListStock(page, stock);
      return jobList;
    } catch (e) {
      throw GetJobListFailure();
    }
  }

  Future<List<JobListInfo>> getSearch(String searchText) async {
    try {
      final searchList = await _jobApi.searchJobList(searchText);
      return searchList;
    } catch (e) {
      throw GetJobListFailure();
    }
  }

  Future<List<JobListInfo>> getSearchStatus(
      String status, String startDate, String endDate) async {
    try {
      final searchList =
          await _jobApi.searchJobListStatus(startDate, endDate, status);
      return searchList;
    } catch (e) {
      throw GetJobListFailure();
    }
  }

  Future<List<JobListInfo>> notiJobList(String pk, String cardType) async {
    final jobList = await _jobApi.notiJobList(pk, cardType);
    return jobList;
  }

  Future<List<NoteInfo>> getNoteAll(int pk, String cardtype) async {
    final noteAllList = await _jobApi.getNoteAll(pk, cardtype);
    return noteAllList;
  }

  Future<List<FileInfo>> getFileAll(int pk, String cardtype) async {
    final noteAllList = await _jobApi.getFileAll(pk, cardtype);
    return noteAllList;
  }

  Future<List<NoteInfo>> getNote({required int pk}) async {
    try {
      final noteList = await _jobApi.getNote(pk);
      return noteList;
    } catch (e) {
      return [];
    }
  }

  Future<List<NoteInfo>> getNoteSO(
      {required int pk, required int stepStatusScan}) async {
    try {
      final noteList = await _jobApi.getNoteSO(pk, stepStatusScan);
      return noteList;
    } catch (e) {
      return [];
    }
  }

  Future<List<NoteInfo>> getNoteKK(
      {required int pk, required int stepStatusScan}) async {
    try {
      final noteList = await _jobApi.getNoteKK(pk, stepStatusScan);
      return noteList;
    } catch (e) {
      return [];
    }
  }

  Future<List<FileInfo>> getFilePO(
      {required int pk, required int stepStatusScan}) async {
    try {
      final fileList = await _jobApi.getFilePO(pk, stepStatusScan);
      return fileList;
    } catch (e) {
      return [];
    }
  }

  Future<List<FileInfo>> getFileSO(
      {required int pk, required int stepStatusScan}) async {
    try {
      final fileList = await _jobApi.getFileSO(pk, stepStatusScan);
      return fileList;
    } catch (e) {
      return [];
    }
  }

  Future<bool> postNotePO({
    required String? title,
    required String? note,
    required String? purchaseOrder,
    required String? creationUser,
    required String? stepStatusScan,
    required String? type,
  }) async {
    try {
      final postNotePO = await _jobApi.postNotePO(
          title: title,
          note: note,
          purchaseOrder: purchaseOrder,
          creationUser: creationUser,
          stepStatusScan: stepStatusScan,
          type: type);
      return postNotePO;
    } catch (e) {
      return false;
    }
  }

  Future<bool> postNoteKK({
    required String title,
    required String note,
    required String purchaseOrder,
    required String creationUser,
    required String stepStatusScan,
  }) async {
    try {
      final postNotePO = await _jobApi.postNoteKK(
          title: title,
          note: note,
          purchaseOrder: purchaseOrder,
          creationUser: creationUser,
          stepStatusScan: stepStatusScan);
      return postNotePO;
    } catch (e) {
      return false;
    }
  }

  Future<bool> postNoteSO({
    required String title,
    required String note,
    required String purchaseOrder,
    required String creationUser,
    required String stepStatusScan,
  }) async {
    try {
      final postNotePO = await _jobApi.postNoteSO(
          title: title,
          note: note,
          purchaseOrder: purchaseOrder,
          creationUser: creationUser,
          stepStatusScan: stepStatusScan);
      return postNotePO;
    } catch (e) {
      return false;
    }
  }

  Future<bool> postNoteFilePO({
    required String order,
    required File attachment,
    required String fileName,
    required String comment,
    required String creationUser,
    required String stepStatusScan,
    required String type,
  }) async {
    try {
      final postNoteFilePO = await _jobApi.postNoteFilePO(
          order: order,
          attachment: attachment,
          fileName: fileName,
          comment: comment,
          creationUser: creationUser,
          stepStatusScan: stepStatusScan,
          type: type);
      return postNoteFilePO;
    } catch (e) {
      return false;
    }
  }

  Future<QuantityScanTotal> getQuantityScanTotal({required int pk}) async {
    final data = await _jobApi.getInfoTotalScan(pk: pk);
    return data;
  }

  Future<bool> postNoteFileSO({
    required String order,
    required File attachment,
    required String fileName,
    required String comment,
    required String creationUser,
    required String stepStatusScan,
  }) async {
    try {
      final postNoteFileSO = await _jobApi.postNoteFileSO(
          order: order,
          attachment: attachment,
          fileName: fileName,
          comment: comment,
          creationUser: creationUser,
          stepStatusScan: stepStatusScan);
      return postNoteFileSO;
    } catch (e) {
      return false;
    }
  }

  Future<HireWorkers> getHireWorkers({required int pk}) async {
    final data = await _jobApi.getHireWorkers(pk: pk);
    return data;
  }

  Future settingDivice({required String id}) async {
    try {
      final setting = await _jobApi.settingDivice(id: id);
      return setting;
    } catch (e) {
      return false;
    }
  }

  Future<int?> putHireWorkers({
    required int pk,
    required String? quantity,
  }) async {
    final data = await _jobApi.putHireWorkers(pk: pk, quantity: quantity);
    return data;
  }

  Future<List<StockSO>> getStockSO({required int pk}) async {
    final data = await _jobApi.getStockSO(pk: pk);
    return data;
  }

  Future<QuantityScanDeclaration> getQuantityScanDeclaration(
      {required int pk}) async {
    final data = await _jobApi.getQuantityScanDeclaration(pk: pk);
    return data;
  }
  Future<StatusStocktaking> getStatusStocktaking({required int pk})async{
    final data = await _jobApi.getStatusStocktaking(pk: pk);
    return data;
  }

  Future<void> postComplatedDeclaration({required int pk}) async {
    await _jobApi.postComplatedDeclaration(pk: pk);
  }

  Future<void> postComplatedStocktaking({required int pk}) async {
    await _jobApi.postComplatedStocktaking(pk: pk);
  }
}
