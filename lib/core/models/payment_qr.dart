import 'package:bsg/api/repository/repositories_api.dart';
import 'package:bsg/core/models/base_model.dart';
import 'package:flutter/cupertino.dart';

class PaymentModel extends BaseBloc{

  BsgAPI _bsgAPI = BsgAPI();


  Future doPaymentByScanner(String str,BuildContext context){
    setLoading(true);
    return _bsgAPI.doPaymentByScanner(str,context)
      .then((value) {
        if(value != null)
        setLoading(false);
      })   
      .catchError((error){
        setLoading(false);
      })   
      .whenComplete((){
        setLoading(false);
      });
  }
  
}