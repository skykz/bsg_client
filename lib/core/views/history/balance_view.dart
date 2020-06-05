import 'package:bsg/core/models/history_model.dart';
import 'package:flutter/material.dart';

class BalanceView extends StatelessWidget {
  final HistoryModel model;
  BalanceView({this.model});

  @override
  Widget build(BuildContext context) {
    final mainStyle = TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15);

    final secondary = TextStyle(color: Colors.black, fontSize: 13);

    return Column(
      children: <Widget>[
        Container(
          height: 50,
          color: Colors.grey[300],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "Дата / \n Тип",
                style: mainStyle,
              ),
              Text(
                "Сумма",
                style: mainStyle,
              ),
              Text(
                "Отправитель /\n Получатель",
                style: mainStyle,
              ),
            ],
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.62,
            child: StreamBuilder(
                stream: model.getTransactionsBalance(1, context).asStream(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: <Widget>[
                            CircularProgressIndicator(
                              backgroundColor: Colors.orange,
                              strokeWidth: 3,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Загрузка...")
                          ],
                        ),
                      ),
                    );
                  if (snapshot.hasError)
                    return Center(
                      child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text("${snapshot.error}")),
                    );

                  if (snapshot.data['data'].length < 1)
                    return Center(
                      child: Text("Нету данных."),
                    );

                  return ListView.builder(
                      itemCount: 15,
                      itemExtent: 80,
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      "sdfsddf",
                                      style: secondary,
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.green[300],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "зачисление",
                                          style: TextStyle(color: Colors.white),
                                        ))
                                  ],
                                ),
                                Center(
                                    child: Text(
                                  "10 000,00",
                                  style: TextStyle(color: Colors.green),
                                )),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      "sdfsddf",
                                      style: secondary,
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "мой счет",
                                          style: TextStyle(color: Colors.white),
                                        ))
                                  ],
                                ),
                              ],
                            ));
                      });
                })),
      ],
    );
  }
}
