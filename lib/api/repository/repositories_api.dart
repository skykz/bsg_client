import 'package:bsg/api/network_call.dart';
import 'package:flutter/material.dart';

class BsgAPI {
  static BsgAPI _instance = BsgAPI.internal();
  BsgAPI.internal();
  factory BsgAPI() => _instance;

  NetworkCall _networkCall = NetworkCall();

  //common
  static const GET_COUNTRY_CODES = 'country_phone_codes';
  static const AUTH_REGISTER = 'auth/register';
  static const AUTH_LOGIN = 'auth/login';
  static const AUTH_LOGOUT = 'auth/logout';
  static const GET_BALANCE = 'balance';

  static const COOR_CLIENT_SALES_ACCEPT = 'client/sales/accept';
  static const COOR_CLIENT_GET_SALES_REPORTS = 'client/reports/sales';
  static const COOR_CLIENT_GET_REPORT_TRANSACTIONS = 'client/reports/transactions';
  static const COOR_CLIENT_TRANSFERS_SEARCH_USER = 'client/transfers/search_user';
  static const COOR_CLIENT_TRANSFERS = 'client/transfers ';

  //Managers
  static const MANAGER_GET_BALANCE = 'manager/balance';
  static const MANAGER_GET_EMPLOYEES = 'manager/employees';
  static const MANAGER_PUT_TRANSFERS = 'manager/transfers';
  static const MANAGER_SET_EMPLOYEES = 'manager/employees/{id}/status';

  

  Future<dynamic> authLogin(String login,String password,[BuildContext context]) async {
    
      dynamic response = await _networkCall.doRequestAuth(
          path: AUTH_LOGIN,
          method: 'POST',
          context: context,
          body: {
            "login": login,
            "password": password});
            
      return response;     
  }

  Future<dynamic> authLogout([BuildContext context]) async {
    
      dynamic response = await _networkCall.doRequestMain(
          path: AUTH_LOGOUT,
          method: 'POST',
          context: context,
          );
            
      return response;     
  }
  
  Future<dynamic> getClientReportSales([BuildContext context]) async {
    
      dynamic response = await _networkCall.doRequestMain(
          path: COOR_CLIENT_GET_SALES_REPORTS,
          method: 'GET',
          context: context,                         
          requestParams: {
            'page':1,
            'per_page':15
          }
      );
            
      return response;     
  }
  
  Future<dynamic> getTransactionsBalance(int page,[BuildContext context]) async {
    
      dynamic response = await _networkCall.doRequestMain(
          path: COOR_CLIENT_GET_REPORT_TRANSACTIONS,
          method: 'GET',
          context: context,       
          requestParams: {
            'page':page
          }  
          );
            
      return response;     
  }

  Future<dynamic> doPaymentByScanner(String object,[BuildContext context]) async {
    
      dynamic response = await _networkCall.doRequestMain(
          path: COOR_CLIENT_SALES_ACCEPT,
          method: 'PUT',
          body: {
            'qr_code':object
          },
          context: context,         
          );
            
      return response;     
  }

  // Future<dynamic> doRefund(int id,[BuildContext context]) async {
    
  //     dynamic response = await _networkCall.doRequestMain(
  //         path: CASHIER_SALES_REFUND_BY_ID+"$id/refund",
  //         method: 'PUT',
  //         context: context,         
  //         );
            
  //     return response;     
  // }

  // Future<dynamic> getCashierXReports([BuildContext context]) async {
    
  //     dynamic response = await _networkCall.doRequestMain(
  //         path: CASHIER_REPORT_X_REPORT_GET,
  //         method: 'GET',
  //         context: context,         
  //         );
            
  //     return response;     
  // }

  // Future<dynamic> searchSalesById(int id,[BuildContext context]) async {
    
  //     dynamic response = await _networkCall.doRequestMain(
  //         path: "cashier/sales/$id",
  //         method: 'GET',
  //         context: context,                   
  //     );
            
  //     return response;     
  // }

  // Future<dynamic> confirmPayment(int id,[BuildContext context]) async {
    
  //     dynamic response = await _networkCall.doRequestMain(
  //         path: CASHIER_SALES_PAID_BY_ID+"$id/paid",
  //         method: 'PUT',
  //         context: context,         
  //         );
            
  //     return response;     
  // }


  //  Future<dynamic> closeCashierShift([BuildContext context]) async {
    
  //     dynamic response = await _networkCall.doRequestMain(
  //         path: CASHIER_SHIFT_CLOSE,
  //         method: 'PUT',
  //         context: context,                 
  //     );
            
  //     return response;     
  // }

  Future<dynamic> getNextOrPrevPage(String url,[BuildContext context]) async {
    
      dynamic response = await _networkCall.doRequestMain(
          path: url,
          method: 'GET',
          context: context,                   
      );            
      return response;     
  }
}
