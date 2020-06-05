import 'package:bsg/core/models/history_model.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget {
  final HistoryModel model;
  HistoryView({this.model});

  String year;  

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
                "Дата",
                style: mainStyle,
              ),
              Text(
                "Топливо",
                style: mainStyle,
              ),
              Text(
                "АЗС",
                style: mainStyle,
              ),
              Text(
                "Литры",
                style: mainStyle,
              ),
              Text(
                "Сумма",
                style: mainStyle,
              )
            ],
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.62,
            child: StreamBuilder(
                stream: model.getReportSales(1, 10, context).asStream(),
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

                  if(snapshot.data['data'].length < 1)
                      return Center(
                        child: Text("Нету данных."),
                      );

                  return ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      itemExtent: 70,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {      
                         DateTime a = DateTime.tryParse(snapshot.data['data'][i]['datetime']); 
                         String b = TimeOfDay.fromDateTime(a).format(context);                                                                     
                         year = "${DateTime.parse(snapshot.data['data'][i]['datetime']).year}-${DateTime.parse(snapshot.data['data'][i]['datetime']).month}-${DateTime.parse(snapshot.data['data'][i]['datetime']).day}";                        
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[                              
                              Text(
                                "$year \n $b",
                                style: secondary,
                              ),
                              Text(
                                "${snapshot.data['data'][i]['fuel']}",
                                style: secondary,
                              ),
                              Text(
                                "${snapshot.data['data'][i]['provider_department']}",
                                style: secondary,
                              ),
                              Text(
                                "${snapshot.data['data'][i]['quantity']}",
                                style: secondary,
                              ),
                              Text(
                                "${snapshot.data['data'][i]['total_price']}",
                                style: secondary,
                              )
                            ],
                          ),
                        );
                      });
                })),
      ],
    );
  }
}
