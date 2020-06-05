import 'package:bsg/core/models/base_provider.dart';
import 'package:bsg/core/models/payment_qr.dart';
import 'package:flutter/material.dart';

class PaymentStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseProvider<PaymentModel>(
      model: PaymentModel(),
      builder: (context, model, child) => Scaffold(
      appBar: AppBar(
        title: const Text('Оплата'),
        backgroundColor: Colors.orange,),
      body: SingleChildScrollView(
              child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[            
              Text(
                !model.isLoading?"Ожидайте подтверждения кассира":"Оплата произведена успешно!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 26),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10,bottom: 40),
                child: Center(
                  child: model.isLoading?Icon(Icons.check_circle_outline,size: 100,color: Colors.green,):CircularProgressIndicator(
                    strokeWidth: 3,
                    backgroundColor: Colors.purple,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Text(
                      "Данные транзакции:",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                  text: 'Дата и время: ',
                                  style: TextStyle(fontSize: 18)),
                              TextSpan(
                                  text: ' 09.04.2020 8:23',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18)),
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                  text: 'Тип бензина: ',
                                  style: TextStyle(fontSize: 18)),
                              TextSpan(
                                  text: ' 09.04.2020 8:23',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18)),
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                  text: 'Цена за литр: ',
                                  style: TextStyle(fontSize: 18)),
                              TextSpan(
                                  text: ' 09.04.2020 8:23',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18)),
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                  text: 'Количество литров: ',
                                  style: TextStyle(fontSize: 18)),
                              TextSpan(
                                  text: ' 09.04.2020 8:23',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18)),
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                  text: 'Сумма: ',
                                  style: TextStyle(fontSize: 18)),
                              TextSpan(
                                  text: ' 09.04.2020 8:23',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18)),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Colors.grey,
                        splashColor: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.all(13),
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: const Text(
                            "Ок",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context)),
              ),                            
            ],
          ),
        ),
      ),
     ),
    );
  }
}
