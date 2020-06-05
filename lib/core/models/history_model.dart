import 'package:bsg/api/repository/repositories_api.dart';
import 'package:bsg/core/models/base_model.dart';
import 'package:flutter/widgets.dart';

class HistoryModel extends BaseBloc{

  BsgAPI _api = BsgAPI();

  Future getReportSales ([int page,int perPage,BuildContext context]) async {
    return await _api.getClientReportSales(context);
  } 

  Future getTransactionsBalance (int page,BuildContext context) async {
    return await _api.getTransactionsBalance(page,context);
  } 


} 