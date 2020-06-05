import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  @override
  createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewScreen> {
  final _key = UniqueKey();
  bool _isLoadingPage;

  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    _isLoadingPage = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text("Вебвью"),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            key: _key,
            initialUrl: "https://api.elitefuel.kz/azs",
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (webViewCreate) {
              _controller.complete(webViewCreate);
            },
            onPageFinished: (finish) {
              setState(() {
                _isLoadingPage = false;
              });
            },
          ),
          _isLoadingPage
              ? Container(
                  alignment: FractionalOffset.center,
                  color: Colors.green[50].withOpacity(0.9),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.purpleAccent,
                    ),
                  ),
                )
              : Visibility(
                  child: Container(
                    color: Colors.transparent,
                  ),
                  visible: false,
                )
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (_controller != null) _controller = null;
    super.dispose();
  }
}
