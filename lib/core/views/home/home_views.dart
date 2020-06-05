import 'dart:developer';

import 'package:bsg/api/repository/repositories_api.dart';
import 'package:bsg/core/models/base_provider.dart';
import 'package:bsg/core/models/home_model.dart';
import 'package:bsg/core/models/mqtt_model.dart';
import 'package:bsg/core/services/mqtt_class.dart';
import 'package:bsg/core/views/account/account_settings.dart';
import 'package:bsg/core/views/history/tab_history.dart';
import 'package:bsg/core/views/payment/payment_create.dart';
import 'package:bsg/core/views/web_view/web_screen.dart';
import 'package:bsg/resources/components/route_custom.dart';
import 'package:bsg/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<HomeScreen> {
  AnimationController _controller;
  BsgAPI _api = BsgAPI();
  Stream<dynamic> getShift;
  Stream<dynamic> checkShiftStatus;

  MQTTAppState currentAppState;
  MQTTManager manager;

  @override
  void initState() {
    // checkShiftStatus = checkShiftStatusIsOpen(context).asStream().asBroadcastStream();
    // getShift = getShiftInfo(context).asStream().asBroadcastStream();

    super.initState();
    _configureAndConnect();
    // _controller = AnimationController(
    //   vsync: this,
    // );
    // _controller.repeat(
    //   period: Duration(milliseconds: 2000),
    // );
  }

  Future<void> _configureAndConnect() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    String server = _sharedPreferences.getString("mqtt_server");
    String username = _sharedPreferences.getString("mqtt_user");
    String password = _sharedPreferences.getString("mqtt_password");
    String topic = _sharedPreferences.getString("mqtt_topic");
    log(server);
    log(username);
    log(password);
    log(topic);

    manager = MQTTManager(
        password: password,
        username: username,
        server: server,
        topic: topic,
        state: currentAppState);
    manager.initializeMQTTClient();
    manager.connect();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildConnectionStateText(Widget child) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              height: 25,
              color: currentAppState.getAppConnectionState ==
                      MQTTAppConnectionState.connected
                  ? Colors.greenAccent[100]
                  : Colors.redAccent[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    " MQTT :",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Center(child: child),
                ],
              )),
        ),
      ],
    );
  }

  // Utility functions
  Widget prepareStateMessageFrom(MQTTAppConnectionState state) {
    switch (state) {
      case MQTTAppConnectionState.connected:
        return Text("Подключен",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18));
      case MQTTAppConnectionState.connecting:
        return SizedBox(
          height: 15,
          width: 15,
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            strokeWidth: 2,
          ),
        );
      case MQTTAppConnectionState.disconnected:
        return Text("Не подключен",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final MQTTAppState appState = Provider.of<MQTTAppState>(context);
    currentAppState = appState;

    return BaseProvider<HomeModel>(
        model: HomeModel(),
        builder: (context, model, child) => SafeArea(
                child: WillPopScope(
              child: Scaffold(
                  backgroundColor: Colors.grey[200],
                  resizeToAvoidBottomInset: false,
                  appBar: PreferredSize(
                      preferredSize:
                          Size.fromHeight(100.0), // here the desired height
                      child: AppBar(
                        elevation: 1,
                        leading:
                            Icon(Icons.account_circle, color: Colors.black45),
                        backgroundColor: Colors.white,
                        iconTheme: IconThemeData(color: Colors.black),
                        centerTitle: true,
                        flexibleSpace: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              "Сергеев Сергей Сергеевич",
                              textAlign: TextAlign.start,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            Text(
                              "ТОО \"Ромашка\", филиал \"Главный\" \n Администратор клиента",
                              textAlign: TextAlign.start,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          IconButton(
                              icon: Icon(Icons.settings, color: Colors.black45),
                              onPressed: () => Navigator.push(
                                  context,
                                  EnterExitRoute(
                                      enterPage: AccountSettingsView())))
                        ],
                      )),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                         _buildConnectionStateText(prepareStateMessageFrom(currentAppState.getAppConnectionState)),
                        Builder(
                          builder: (ctx) => FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              color: Colors.blue[300],
                              splashColor: Colors.white,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                padding: const EdgeInsets.all(15),
                                child: const Text(
                                  "Оплата",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PaymentInfoScreen()))),
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          color: Colors.amber[300],
                          splashColor: Colors.white,
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: const Text(
                              "История",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HistoryMainView())),
                        ),

                        FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: Colors.green[300],
                            splashColor: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: const Text(
                                "Распределение баланса",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onPressed: () => {}),
                        FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: Colors.orange[300],
                            splashColor: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: const Text(
                                "Бизнес",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onPressed: () => {}),
                        FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: Colors.grey,
                            splashColor: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: const Text(
                                "Список АЗС",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebViewScreen())))
                      ],
                    ),
                  )),
              onWillPop: () => exitApp(context),
            )));
  }

  @override
  bool get wantKeepAlive => true;
}
