import 'dart:developer';

import 'package:barcode_scan/platform_wrapper.dart';
import 'package:bsg/core/models/base_provider.dart';
import 'package:bsg/core/models/payment_qr.dart';
import 'package:bsg/core/views/payment/payment_status.dart';
import 'package:bsg/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentInfoScreen extends StatefulWidget {
  @override
  _PaymentInfoScreenState createState() => _PaymentInfoScreenState();
}

class _PaymentInfoScreenState extends State<PaymentInfoScreen> {
  String barcode;

  @override
  Widget build(BuildContext context) {
    return BaseProvider<PaymentModel>(
      model: PaymentModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(),
          backgroundColor: Colors.white,
          title: Text(
            "Оплата",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[           
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: CircleAvatar(
                      backgroundColor: Colors.purple[300],
                      child: Text(
                        "1",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                      radius: 15,
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Center(
                          child: Text(
                        "Сообщите кассиру сумму или количество литров для заправки.",
                        style: TextStyle(fontSize: 17),
                      )))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: CircleAvatar(
                      backgroundColor: Colors.purple[300],
                      child: Text(
                        "2",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                      radius: 15,
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Center(
                          child: Text(
                        "Сообщите кассиру сумму или количество литров для заправки.",
                        style: TextStyle(fontSize: 17),
                      )))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: CircleAvatar(
                      backgroundColor: Colors.purple[300],
                      child: Text(
                        "3",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                      radius: 15,
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Center(
                          child: Text(
                        "Сообщите кассиру сумму или количество литров для заправки.",
                        style: TextStyle(fontSize: 17),
                      )))
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Builder(
                builder: (ctx) => FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.green[300],
                    splashColor: Colors.white,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: model.isLoading? Center(
                        child: SizedBox(
                                    height: 30,
                                    width: 30,
                                     child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                    ):const Text(
                        "Отсканировать QR-код",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentStatus()))),
                    onPressed: () => scan(model, ctx)),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: Colors.grey,
                      splashColor: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.all(13),
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: const Text(
                          "Отменить",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future scan(PaymentModel model, BuildContext ctx) async {
    try {
      var barcode = (await BarcodeScanner.scan());
      log("-------------------- ${barcode.rawContent}");
      if (barcode.rawContent.isNotEmpty){
        model.doPaymentByScanner(barcode.rawContent,ctx)
          .then((value) {
            if(value != null){
                Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => PaymentStatus()));
            }
          });
        showCustomSnackBar(
          ctx, "Отсканировано! ${barcode.rawContent}", Colors.green, Icons.check_circle);
      }
      else{
        showCustomSnackBar(
          ctx, "Вы не отсканировали QR", Colors.orange, Icons.info_outline);
      }
     
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        showCustomSnackBar(ctx, "Вы не дали разрешения на камеру",
            Colors.orange, Icons.info_outline);
      } else {
        showCustomSnackBar(
            ctx, "Неизвестная ошибка: $e", Colors.red, Icons.info_outline);
      }
    }
  }
}
