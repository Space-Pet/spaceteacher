// ignore_for_file: avoid_print

import 'dart:io';

import '../../network_data_source.dart';

class JobApi extends AbstractJobApi {
  JobApi({
    required AbstractDioClient client,
    required RestApiClient authRestClient,
    required RestApiClient partnerTokenRestClient,
  })  : _client = client,
        _authRestClient = authRestClient,
        _partnerTokenRestClient = partnerTokenRestClient;

  final AbstractDioClient _client;
  final RestApiClient _authRestClient;
  final RestApiClient _partnerTokenRestClient;
  Future<String?> getToken() async {
    final token = await _client.getAccessToken();
    return token;
  }

  Future<void> postCreatePo({required Map<String, Object?> data}) async {
    await _client.doPostCreate(
        url: 'api/mobile/order/po/create-po-by-request/', data: data);
  }

  Future<String?> postShare(
      {required List<Map<String, Object>> data, required int pk}) async {
    try {
      final share = await _client.doHttpPost(
        url: 'api/mobile/order/share-file',
        requestBody: {"bins_list": data, "requestmodel": pk},
      );

      if (share.containsKey('data')) {
        String? shareData = share['data'];
        return shareData;
      } else {
        return null;
      }
    } catch (e) {
      print('error: $e');
      return null;
    }
  }

  Future<void> postListBarcodeOptional({
    required int? pk,
    required List<Map<String, Object>>? data,
  }) async {
    try {
      await _client.doPost(
          url: 'api/mobile/update-status-part/?requestmodel=$pk&optional=true',
          data: data);
    } catch (e) {
      print('errors');
    }
  }

  Future<void> complatedStep(
      {required int pk, required String pkStockSO}) async {
    try {
      String pkStockSO = '';
      if (pkStockSO == '') {
        pkStockSO = '';
      } else {
        pkStockSO = '?so=$pkStockSO';
      }
      await _client.doHttpPost(
          url: '/api/mobile/request/$pk/complete/$pkStockSO');
      print('okjj');
    } catch (e) {
      print('loi: $e');
    }
  }

  Future<List<StockInventory>> getStockInventory() async {
    try {
      final data = await _client.doHttpGet('api/mobile/stock/location/');
      final List<StockInventory> list = [];
      final listData = data['data'] as List<dynamic>;
      for (final dataMap in listData) {
        final stock = StockInventory.fromMap(dataMap);
        list.add(stock);
      }
      return list;
    } catch (e) {
      print('error $e');
      return [];
    }
  }

  Future<int?> postListBarcode(
      {required int? pk,
      required int? pkStockPO,
      required List<Map<String, Object>>? data,
      required String? type}) async {
    try {
      String so = '';
      if (pkStockPO != 0) {
        so = '&stock=$pkStockPO';
      } else {
        so = '';
      }
      final status = await _client.doPost(
          url: 'api/mobile/update-status-part/?requestmodel=$pk$so',
          data: data);
      final statusCode = status['statusCode'] ?? 0;
      return statusCode;
    } catch (e) {
      return 0;
    }
  }

  Future<void> complatedTicketPO({required List pk}) async {
    try {
      for (var item in pk) {
        await _client.doHttpPost(url: 'api/mobile/order/po/$item/complete/');
      }
      print('oks');
    } catch (e) {
      print('loio: $e');
    }
  }

  Future<List<BarcodeInfo>> getBarcode({required int pk}) async {
    try {
      final data = await _client.doHttpGet('api/mobile/part/?requestmodel=$pk');
      final barcodeData = data['data'] as List<dynamic>;
      List<BarcodeInfo> barcodeList = [];
      for (final barcode in barcodeData) {
        final map = BarcodeInfo.fromMap(barcode);
        barcodeList.add(map);
      }
      print('ok');
      return barcodeList;
    } catch (e) {
      print('lỗi: $e');
      return [];
    }
  }

  Future<void> postComplatedStocktaking({required int pk}) async {
    try {
      await _client.doHttpPost(
          url: 'api/mobile/stock/stocktaking/$pk/complete/');
      print('work');
    } catch (e) {
      print('object: $e');
    }
  }

  Future<List<BarcodeDeclaration>> getBarcodeDeclaration(
      {required int pk}) async {
    try {
      final data = await _client
          .doHttpGet('api/mobile/stock/declaration-location/$pk/binslist/');
      final barcodeData = data['data'] as List<dynamic>;
      List<BarcodeDeclaration> barcodeList = [];
      for (final barcode in barcodeData) {
        final map = BarcodeDeclaration.fromMap(barcode);
        barcodeList.add(map);
      }
      print('object');
      return barcodeList;
    } catch (e) {
      print('error: $e');
      return [];
    }
  }

  Future<List<BarcodeDeclaration>> getBarcodeStocktaking(
      {required int pk}) async {
    final data =
        await _client.doHttpGet('api/mobile/stock/stocktaking/$pk/binslist/');
    final barcodeData = data['data'] as List<dynamic>;
    List<BarcodeDeclaration> barcodeList = [];
    for (final barcode in barcodeData) {
      final map = BarcodeDeclaration.fromMap(barcode);
      barcodeList.add(map);
    }
    return barcodeList;
  }

  Future<int?> postBarcodeDeclaration(
      {required int type,
      required int pk,
      required List<Map<String, Object>>? data}) async {
    String typePost;
    if (type == 1) {
      typePost = '&declaration_type=1';
    } else {
      typePost = '';
    }
    try {
      final status = await _client.doPost(
          url:
              'api/mobile/stock/update-status-binslist/?declaration_scan=true&declaration=$pk$typePost',
          data: data);
      final int? statusCode = status['statusCode'] ?? 0;
      return statusCode;
    } catch (e) {
      print('error: $e');
      return 0;
    }
  }

  Future<int?> postBarcodeStocktaking(
      {required int pk, required List<Map<String, Object>>? data}) async {
    try {
      final status = await _client.doPost(
          url:
              'api/mobile/stock/update-status-binslist/?stocktaking_scan=true&stocktaking=$pk',
          data: data);
      final statusCode = status['statusCode'] ?? 0;
      return statusCode;
    } catch (e) {
      return 0;
    }
  }

  Future<List<RequestInfo>> getRequestTicket(
      {required String page,
      String? active,
      String? startDate,
      String? endDate,
      String? search}) async {
    try {
      final data = await _client.doHttpGet(
          'api/mobile/get_request_task/?page=$page&start_date=$startDate&end_date=$endDate&search=$search&active=$active');
      final statusCode = data['statusCode'];
      if (statusCode == 200) {
        final requestData = data['data'];
        final List<RequestInfo> dataList = [];
        final count = requestData['count'] ?? 0;
        final List<dynamic> requestResult = requestData['result'];
        final List<RequestData> jobList = [];

        for (final requestMap in requestResult) {
          final requestData = RequestData.fromMap(requestMap);
          jobList.add(requestData);
        }

        final requestInfo = RequestInfo(
          count: count,
          result: jobList,
        );
        dataList.add(requestInfo);
        return dataList;
      } else {
        throw GetJobListFailure();
      }
    } catch (e) {
      print('error; $e');
      throw GetJobListFailure();
    }
  }

  Future<QuantityScanTotal> getInfoTotalScan({required int pk}) async {
    final data = await _client.doHttpGet('api/mobile/request/$pk/');
    final dataInfo = data['data'] as Map<String, dynamic>;
    final info = QuantityScanTotal.fromMap(dataInfo);
    return info;
  }

  Future<void> postComplatedDeclaration({required int pk}) async {
    try {
      await _client.doHttpPost(
        url: 'api/mobile/stock/declaration-location/$pk/complete/',
      );
    } catch (e) {
      print('error: $e');
    }
  }

  Future<QuantityScanDeclaration> getQuantityScanDeclaration(
      {required int pk}) async {
    final data =
        await _client.doHttpGet('api/mobile/stock/declaration-location/$pk/');
    final dataInfo = data['data'] as Map<String, dynamic>;
    final info = QuantityScanDeclaration.fromMap(dataInfo);
    return info;
  }

  Future<StatusStocktaking> getStatusStocktaking({required int pk}) async {
    final data = await _client.doHttpGet('api/mobile/stock/stocktaking/$pk/');
    final dataInfo = data['data'] as Map<String, dynamic>;
    final info = StatusStocktaking.fromMap(dataInfo);
    return info;
  }

  Future<List<EmptyBox>> getLines({required int pk}) async {
    try {
      final data =
          await _client.doHttpGet('api/mobile/order/so/?requestmodel=$pk');
      final dataList = data['data'] as List<dynamic>;
      List<EmptyBox> emptyBoxList = [];

      for (final orderData in dataList) {
        final linesStepList = orderData['lines_step'] as List<dynamic>;
        for (final lineStep in linesStepList) {
          final box = EmptyBox.fromMap(lineStep);
          emptyBoxList.add(box);
        }
      }

      print(emptyBoxList);
      return emptyBoxList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<StatusLine>> getStatusLine({required int pk}) async {
    try {
      final data =
          await _client.doHttpGet('api/mobile/order/so/?requestmodel=$pk');
      final dataList = data['data'] as List<dynamic>;
      List<StatusLine> statusLine = [];
      for (final orderData in dataList) {
        final box = StatusLine.fromMap(orderData);
        statusLine.add(box);
      }
      return statusLine;
    } catch (e) {
      return [];
    }
  }

  Future<int?> putLines(
      {required int pk, required List<Map<String, Object>> data}) async {
    try {
      final lines =
          await _client.doPut(url: 'api/mobile/order/so/$pk/', data: data);
      int? statusCode = lines['statusCode'];
      return statusCode;
    } catch (e) {
      return 0;
    }
  }

  Future<List<JobListInfo>> getJobListNotReceived(String page, String startDate,
      String endDate, String status, String search) async {
    try {
      final data = await _client.doHttpGet(
          'api/mobile/joblist/?start_date=$startDate&end_date=$endDate&status=$status&page=$page&ordering=desc&search=$search');
      final statusCode = data['statusCode'];
      if (statusCode == 200) {
        final jobListDataList = data['data']['result'] as List<dynamic>;
        List<JobListInfo> jobList = [];

        for (final jobListData in jobListDataList) {
          final jobListInfo = JobListInfo.fromMap(jobListData);
          jobList.add(jobListInfo);
        }
        return jobList;
      } else {
        throw GetJobListFailure();
      }
    } catch (e) {
      throw GetJobListFailure();
    }
  }

  Future<List<TicketDeclaration>> getTicketDeclaration(
      String startDate, String endDate, String status, String search) async {
    try {
      final data = await _client.doHttpGet(
          'api/mobile/stock/declaration-location/?start_date=$startDate&end_date=$endDate&status=$status&ordering=desc&search=$search');

      final dataTicket = data['data'] as List<dynamic>;

      List<TicketDeclaration> listData = [];

      for (final listDataTicket in dataTicket) {
        final list = TicketDeclaration.fromMap(listDataTicket);
        listData.add(list);
      }

      return listData;
    } catch (e) {
      print('error: $e');
      return [];
    }
  }

  Future<List<JobListInfo>> getJobListNotReceivedStock(
      String page,
      String startDate,
      String endDate,
      String status,
      String search,
      String stock) async {
    try {
      final data = await _client.doHttpGet(
          'api/mobile/joblist/?start_date=$startDate&end_date=$endDate&status=$status&page=$page&ordering=desc&search=$search&stock_id=$stock');
      final statusCode = data['statusCode'];
      if (statusCode == 200) {
        final jobListDataList = data['data']['result'] as List<dynamic>;
        List<JobListInfo> jobList = [];

        for (final jobListData in jobListDataList) {
          final jobListInfo = JobListInfo.fromMap(jobListData);
          jobList.add(jobListInfo);
        }
        return jobList;
      } else {
        throw GetJobListFailure();
      }
    } catch (e) {
      throw GetJobListFailure();
    }
  }

  Future<List<JobListInfo>> getJobListStock(String page, String stock) async {
    try {
      final data = await _client
          .doHttpGet('api/mobile/joblist/?page=$page&stock_id=$stock');
      final statusCode = data['statusCode'];

      if (statusCode == 200) {
        final jobListDataList = data['data']['result'] as List<dynamic>;
        List<JobListInfo> jobList = [];

        for (final jobListData in jobListDataList) {
          final jobListInfo = JobListInfo.fromMap(jobListData);
          jobList.add(jobListInfo);
        }
        return jobList;
      } else {
        throw GetJobListFailure();
      }
    } catch (e) {
      throw GetJobListFailure();
    }
  }

  Future<List<BarcodeInfo>> getBarcodeListForJob(
      int? pk, String? cardType, int page) async {
    try {
      final data = await _client.doHttpGet(
        'api/mobile/list_box/?pk=$pk&card_type=$cardType&page=$page',
        requestBody: {"step": 1001},
      );
      final statusCode = data['statusCode'];

      if (statusCode == 200) {
        final jobListDataList = data['data']['result'] as List<dynamic>;
        List<BarcodeInfo> jobList = [];

        for (final jobListData in jobListDataList) {
          final jobListInfo = BarcodeInfo.fromMap(jobListData);
          jobList.add(jobListInfo);
        }
        return jobList;
      } else {
        throw GetJobListFailure();
      }
    } catch (e) {
      return [];
    }
  }

  Future<NumberStep> getNumberStep(int pk, String cardType) async {
    try {
      final data = await _client.doHttpGet(
          'api/mobile/list_box/?pk=$pk&card_type=$cardType',
          requestBody: {
            "arr_status_scan": [1001, 1002, 1003, 1004, 1005],
            "received": "BS"
          });
      final numberStepData = data['data'] as Map<String, dynamic>;
      final numberStepInfo = NumberStep.fromMap(numberStepData);
      return numberStepInfo;
    } catch (e) {
      throw GetJobListFailure();
    }
  }

  Future<List<BarcodeInfo>> getBarcodeListForJobKK(
      int? pk, String? cardType) async {
    try {
      final data = await _client.doHttpGet(
          'api/mobile/list_box/?pk=$pk&card_type=$cardType&status_scan=1001');
      final dataList = data['data'] as List<dynamic>;
      final getDataList =
          dataList.map((item) => BarcodeInfo.fromMap(item)).toList();
      return getDataList;
    } catch (e) {
      return [];
    }
  }

  Future<List<FaqInfo>> getFaq(String search) async {
    try {
      final data = await _client.doHttpGet('api/mobile/faq/?search=$search');
      final dataList = data['data'] as List<dynamic>;
      final getDataList =
          dataList.map((item) => FaqInfo.fromMap(item)).toList();
      return getDataList;
    } catch (e) {
      return [];
    }
  }

  Future<List<GetListUser>> getListUser() async {
    try {
      final data = await _client.doHttpGet('api/mobile/get-user/?role=GN');
      final dataList = data['data'] as List<dynamic>;
      final getDataList =
          dataList.map((item) => GetListUser.fromMap(item)).toList();
      return getDataList;
    } catch (e) {
      return [];
    }
  }

  Future<List<GetListUser>> getListUserTK() async {
    try {
      final data = await _client.doHttpGet('api/mobile/get-user/?role=TK');
      final dataList = data['data'] as List<dynamic>;
      final getDataList =
          dataList.map((item) => GetListUser.fromMap(item)).toList();
      return getDataList;
    } catch (e) {
      return [];
    }
  }

  Future<List<NotificationInfo>> getNotification() async {
    try {
      final data = await _client.doHttpGet('api/mobile/notifications/');
      final dataList = data['data'] as List<dynamic>;
      final getDataList =
          dataList.map((item) => NotificationInfo.fromJson(item)).toList();
      return getDataList;
    } catch (e) {
      return [];
    }
  }

  Future<void> postAssignPO(String po, String user) async {
    await _client.doHttpPost(
        url: 'api/mobile/manage-user-order-po/?pk_po=$po&pk_user=$user');
  }

  Future<void> postAssignSO(String so, String user) async {
    await _client.doHttpPost(
        url: 'api/mobile/manage-user-order-so/?pk_kk=$so&pk_user=$user');
  }

  Future<void> postAssignKK(String kk, String user) async {
    await _client.doHttpPost(
        url: 'api/mobile/manage-user-order-kk/?pk_kk=$kk&pk_user=$user');
  }

  Future<List<StockInfo>> getStockerInfo() async {
    try {
      final data = await _client.doHttpGet('api/mobile/get_stock/');
      final dataList = data['data'] as List<dynamic>;
      final stockInfoList =
          dataList.map((item) => StockInfo.fromMap(item)).toList();
      return stockInfoList;
    } catch (e) {
      return [];
    }
  }

  Future<List<Stocktaking>> getStocktaking({required int pk}) async {
    final data =
        await _client.doHttpGet('api/mobile/stock/stocktaking/?stock=$pk');
    final dataList = data['data'] as List<dynamic>;
    final StocktakingList =
        dataList.map((e) => Stocktaking.fromMap(e)).toList();
    return StocktakingList;
  }

  Future<List<StockInfo>> getStockerInfoId(int? stockId) async {
    try {
      final data =
          await _client.doHttpGet('api/mobile/get_stock/?stock_id=$stockId');
      final dataList = data['data'] as List<dynamic>;
      final stockInfoList =
          dataList.map((item) => StockInfo.fromMap(item)).toList();
      return stockInfoList;
    } catch (e) {
      return [];
    }
  }

  Future<List<NoteInfo>> getNoteAll(int pk, String cardtype) async {
    try {
      final String status;
      final String type;
      final String pkTicket;
      if (cardtype == 'PO') {
        type = 'request';
        status = 'order';
        pkTicket = '?requestmodel=${pk.toString()}';
      } else if (cardtype == 'SO') {
        type = 'request';
        status = 'order';
        pkTicket = '?requestmodel=${pk.toString()}';
      } else if (cardtype == 'declaration') {
        type = 'stock/declaration-location';
        pkTicket = '?declaration=${pk.toString()}';
      } else if (cardtype == 'stocktaking') {
        type = 'stocktaking';
        pkTicket = '?stocktaking=${pk.toString()}';
      } else {
        type = 'request';
        status = '';
        pkTicket = '?requestmodel=${pk.toString()}';
      }
      final data = await _client
          .doHttpGet('api/mobile/$type/note/$pkTicket&user_detail=true');
      final dataList = data['data'] as List<dynamic>;
      final noteInfo = dataList
          .map((item) => NoteInfo.fromMap(item as Map<String, dynamic>))
          .toList();
      return noteInfo;
    } catch (e) {
      print('error: $e');
      return [];
    }
  }

  Future<List<FileInfo>> getFileAll(int pk, String cardtype) async {
    try {
      final String type;
      final String ticket;
      if (cardtype == 'PO') {
        type = 'request';
        ticket = 'requestmodel';
      } else if (cardtype == 'SO') {
        type = 'request';
        ticket = 'requestmodel';
      } else if (cardtype == 'stocktaking') {
        type = 'stocktaking';
        ticket = 'stocktaking';
      } else if (cardtype == 'declaration') {
        type = 'stock/declaration-location';
        ticket = 'declaration';
      } else {
        type = 'request';
        ticket = 'requestmodel';
      }
      final data =
          await _client.doHttpGet('api/mobile/$type/attachment/?$ticket=$pk');
      final dataList = data['data'] as List<dynamic>;
      final noteInfo = dataList.map((item) => FileInfo.fromMap(item)).toList();
      return noteInfo;
    } catch (e) {
      print('error: $e');
      return [];
    }
  }

  Future<List<NoteInfo>> getNote(int pk) async {
    try {
      final data = await _client.doHttpGet(
        'api/mobile/po/note/$pk/',
      );
      final dataList = data['data'] as List<dynamic>;
      final noteInfo = dataList.map((item) => NoteInfo.fromMap(item)).toList();
      return noteInfo;
    } catch (e) {
      return [];
    }
  }

  Future<List<NoteInfo>> getNoteKK(int pk, int stepStatusScan) async {
    try {
      final data = await _client.doHttpGet(
        'api/mobile/stocktaking/note/$pk/',
        requestBody: {"step": stepStatusScan},
      );
      final dataList = data['data'] as List<dynamic>;
      final noteInfo = dataList.map((item) => NoteInfo.fromMap(item)).toList();
      return noteInfo;
    } catch (e) {
      return [];
    }
  }

  Future<List<NoteInfo>> getNoteSO(int pk, int stepStatusScan) async {
    try {
      final data = await _client.doHttpGet(
        'api/mobile/so/note/$pk/',
        requestBody: {"step": stepStatusScan},
      );
      final dataList = data['data'] as List<dynamic>;
      final noteInfo = dataList.map((item) => NoteInfo.fromMap(item)).toList();
      return noteInfo;
    } catch (e) {
      return [];
    }
  }

  Future<List<FileInfo>> getFilePO(int pk, int stepStatusScan) async {
    try {
      final data = await _client.doHttpGet(
        'api/mobile/po/attachment/$pk/',
        requestBody: {"step": stepStatusScan},
      );
      final dataList = data['data'] as List<dynamic>;
      final fileInfo = dataList.map((item) => FileInfo.fromMap(item)).toList();
      return fileInfo;
    } catch (e) {
      return [];
    }
  }

  Future<List<FileInfo>> getFileSO(int pk, int stepStatusScan) async {
    try {
      final data = await _client.doHttpGet(
        'api/mobile/so/attachment/$pk/',
        requestBody: {"step": stepStatusScan},
      );
      final dataList = data['data'] as List<dynamic>;
      final fileInfo = dataList.map((item) => FileInfo.fromMap(item)).toList();
      return fileInfo;
    } catch (e) {
      return [];
    }
  }

  Future<List<BarcodeInfo>> postBarcodeList(
    int? pk,
    String cardType, {
    required String barcode,
    required int? status,
    required String lastUpdated,
  }) async {
    try {
      final data = await _client.doHttpPut(
        url: 'api/mobile/list_box/?pk=$pk&card_type=$cardType',
        requestBody: {
          "type_scan": cardType,
          "pk": pk,
          "box_info": [
            {"barcode": barcode, "status": status, "last_updated": lastUpdated}
          ]
        },
      );
      if (data['statusCode'] == 200) {
        final List<BarcodeInfo> barcodeList = data['data'];
        for (var barcodeInfo in barcodeList) {
          if (barcodeInfo.barcode == barcode) {
            return barcodeList;
          }
        }
      }
      return <BarcodeInfo>[];
    } catch (e) {
      return <BarcodeInfo>[];
    }
  }

  Future<void> putUnread({required String id}) async {
    await _client.doHttpPut(url: 'api/notifications/read/$id/', requestBody: {
      "unread": "true",
    });
  }

  Future<void> putBoxDataListKK(int pk, String cardType,
      {required String barcode,
      required String cellId,
      required int status}) async {
    await _client.doHttpPut(
        url: 'api/mobile/list_box/?pk=$pk&card_type=$cardType&status_scan=1001',
        requestBody: {
          "type_scan": cardType,
          "status_KK": status,
          "old_cell": cellId,
          "pk": pk,
          "box_info": [
            {"barcode": barcode}
          ]
        });
  }

  Future<void> postBoxDataList({
    required String barcode,
    required String cellId,
    required int? status,
    required int pk,
  }) async {
    await _client.doHttpPost(url: 'api/mobile/on_the_shelf', requestBody: {
      "box_data": [
        {
          "barcode": barcode,
          "status": status,
        }
      ],
      "cell_code": cellId,
      "status": status,
      "pk": pk
    });
  }

  Future<void> postRemoveBoxDataList({
    required String barcode,
    required String cellId,
    required int? status,
    required int pk,
  }) async {
    try {
      await _client
          .doHttpPost(url: 'api/mobile/remove_the_shelf/', requestBody: {
        "box_data": [
          {
            "barcode": barcode,
            "status": status,
          }
        ],
        "cell_code": cellId,
        "status": status,
        "pk": pk
      });
    } catch (e) {}
  }

  Future<List<JobListInfo>> searchJobList(String searchText) async {
    try {
      final data =
          await _client.doHttpGet('api/mobile/joblist/?search=$searchText');

      final statusCode = data['statusCode'];
      if (statusCode == 200) {
        final jobListDataList = data['data']['result'] as List<dynamic>;
        List<JobListInfo> jobList = [];

        for (final jobListData in jobListDataList) {
          final jobListInfo = JobListInfo.fromMap(jobListData);
          jobList.add(jobListInfo);
        }
        return jobList;
      } else {
        throw GetJobListFailure();
      }
    } catch (e) {
      throw GetJobListFailure();
    }
  }

  Future<List<JobListInfo>> notiJobList(String pk, String cardType) async {
    try {
      final data = await _client
          .doHttpGet('api/mobile/joblist/?pk=$pk&card_type=$cardType');

      final statusCode = data['statusCode'];
      if (statusCode == 200) {
        final jobListDataList = data['data']['result'] as List<dynamic>;
        List<JobListInfo> jobList = [];

        for (final jobListData in jobListDataList) {
          final jobListInfo = JobListInfo.fromMap(jobListData);
          jobList.add(jobListInfo);
        }
        return jobList;
      } else {
        throw GetJobListFailure();
      }
    } catch (e) {
      throw GetJobListFailure();
    }
  }

  Future<List<JobListInfo>> searchJobListStatus(
      String endDate, String status, String startDate) async {
    try {
      final data = await _client.doHttpGet(
          'api/mobile/joblist/?start_date=$startDate&end_date=$endDate&status=$status');
      final statusCode = data['statusCode'];
      if (statusCode == 200) {
        final jobListDataList = data['data']['result'] as List<dynamic>;
        List<JobListInfo> jobList = [];

        for (final jobListData in jobListDataList) {
          final jobListInfo = JobListInfo.fromMap(jobListData);
          jobList.add(jobListInfo);
        }
        return jobList;
      } else {
        throw GetJobListFailure();
      }
    } catch (e) {
      throw GetJobListFailure();
    }
  }

  Future<List<CellStock>> getCellStock(int? stockId) async {
    try {
      final data = await _client
          .doHttpGet('api/mobile/get_cell_stock/?stock_id=$stockId');
      final statusCode = data['statusCode'];

      if (statusCode == 200) {
        final cellStockList = data['data'] as List<dynamic>;
        List<CellStock> cellStocks = [];

        for (final cellStockData in cellStockList) {
          final pk = cellStockData['pk']?.toString() ?? '';
          final code = cellStockData['code']?.toString() ?? '';
          final cellStock = CellStock(
            code: code,
            pk: pk,
          );
          cellStocks.add(cellStock);
        }
        return cellStocks;
      } else {
        throw Exception('Failed to fetch cell stock data');
      }
    } catch (e) {
      throw Exception('Failed to fetch cell stock data: $e');
    }
  }

  Future<bool> postNotePO({
    required String? title,
    required String? note,
    required String? creationUser,
    required String? purchaseOrder,
    required String? stepStatusScan,
    required String? type,
  }) async {
    try {
      final String ticket;
      final String purchase;
      if (type == 'PO') {
        ticket = 'request';
        purchase = 'requestmodel';
      } else if (type == 'SO') {
        ticket = 'request';
        purchase = 'requestmodel';
      } else if (type == 'declaration') {
        ticket = 'stock/declaration-location';
        purchase = 'declaration';
      } else if (type == 'stocktaking') {
        ticket = 'stocktaking';
        purchase = 'stocktaking';
      } else {
        ticket = 'request';
        purchase = 'requestmodel';
      }
      await _client.doHttpPost(url: 'api/mobile/$ticket/note/', requestBody: {
        "title": title,
        "note": note,
        purchase: purchaseOrder,
        "creation_user": creationUser,
      });
      return true;
    } catch (e) {
      print('errror: $e');
      throw NoteFailure();
    }
  }

  Future<bool> postNoteKK({
    required String title,
    required String note,
    required String creationUser,
    required String purchaseOrder,
    required String stepStatusScan,
  }) async {
    try {
      await _client
          .doHttpPost(url: 'api/mobile/stocktaking/note/', requestBody: {
        "title": title,
        "note": note,
        "stocktaking": purchaseOrder,
        "creation_user": creationUser,
        "step_status_scan": stepStatusScan,
      });
      return true;
    } catch (e) {
      throw NoteFailure();
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
      await _client.doHttpPost(url: 'api/mobile/so/note/', requestBody: {
        "title": title,
        "note": note,
        "sales_order": purchaseOrder,
        "creation_user": creationUser,
        "step_status_scan": stepStatusScan,
      });
      return true;
    } catch (e) {
      throw NoteFailure();
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
      final String ticket;
      if (type == 'PO') {
        ticket = 'request';
      } else if (type == 'SO') {
        ticket = 'request';
      } else if (type == 'declaration') {
        ticket = 'stock/declaration-location';
      } else if (type == 'stocktaking') {
        ticket = 'stocktaking';
      } else {
        ticket = 'request';
      }
      if (type == 'PO' || type == 'SO') {
        await _client.doHttpPostFile(
          url: 'api/mobile/$ticket/attachment/',
          requestmodel: order,
          comment: comment,
          fileName: fileName,
          attachment: attachment,
          creationUser: creationUser,
        );
      } else if (type == 'declaration') {
        await _client.doHttpPostFile(
          url: 'api/mobile/$ticket/attachment/',
          declaration: order,
          comment: comment,
          fileName: fileName,
          attachment: attachment,
        );
      } else if (type == 'stocktaking') {
        await _client.doHttpPostFile(
          url: 'api/mobile/$ticket/attachment/',
          stocktaking: order,
          comment: comment,
          fileName: fileName,
          attachment: attachment,
        );
      } else {
        await _client.doHttpPostFile(
          url: 'api/mobile/$ticket/attachment/',
          requestmodel: order,
          comment: comment,
          fileName: fileName,
          attachment: attachment,
          creationUser: creationUser,
        );
      }

      return true;
    } catch (e) {
      throw NoteFailure();
    }
  }

  Future<bool> postNoteFileSO({
    required String order,
    required File attachment,
    required String fileName,
    required String comment,
    required String creationUser,
    required String stepStatusScan,
  }) async {
    await _client.doHttpPostFile(
      url: 'api/mobile/so/attachment/',
      order: order,
      comment: comment,
      fileName: fileName,
      attachment: attachment,
      creationUser: creationUser,
    );
    return true;
  }

  Future<int?> putHireWorkers({
    required int pk,
    required String? quantity,
  }) async {
    final data =
        await _client.doHttpPut(url: '/api/mobile/request/$pk/', requestBody: {
      "quantity": quantity != null ? int.tryParse(quantity) ?? 0 : 0,
    });
    int? hireWorkers = data['statusCode'];
    return hireWorkers;
  }

  Future<HireWorkers> getHireWorkers({required int pk}) async {
    final data = await _client.doHttpGet('api/mobile/request/$pk/');
    final dataHireWorkers = data['data'] as Map<String, dynamic>;
    print('oki');
    final HireWorkers hireWorkers = HireWorkers.fromMap(dataHireWorkers);
    print('okli');
    return hireWorkers;
  }

  Future<SettingInfo> settingDivice({required String id}) async {
    try {
      final data =
          await _client.doHttpGet('api/mobile/setting_device/?id_device=$id');
      if (data.containsKey('data')) {
        final settingData = data['data'] as Map<String, dynamic>;
        final settingInfo = SettingInfo.fromMap(settingData);
        return settingInfo;
      } else {
        throw SettingFailure();
      }
    } catch (e) {
      throw SettingFailure();
    }
  }

  Future<List<StockSO>> getStockSO({required int pk}) async {
    try {
      final data =
          await _client.doHttpGet('api/mobile/part/so/?requestmodel=$pk');
      final dataStock = data['data'] as List<dynamic>;
      List<StockSO> listData = [];
      for (final stocks in dataStock) {
        final stockSO = StockSO.fromMap(stocks);
        listData.add(stockSO);
      }
      print('ds');
      return listData;
    } catch (e) {
      print('object: $e');
      return [];
    }
  }
}
