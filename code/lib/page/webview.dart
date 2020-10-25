import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../config/theme.dart';
import '../util/screen_util.dart';

class Webview extends StatefulWidget {
  final String url;
  final String title;
  const Webview({Key key, this.url, this.title}) : super(key: key);

  @override
  _WebviewState createState() => _WebviewState();
}
class _WebviewState extends State<Webview> {

  InAppWebViewController webView;
  double progress = 0;

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
          style: TextStyle(
            color: Color(0xFF303033),
            fontSize: ScreenUtil.fontSize18
          ),
        ),
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: AppTheme.background,
        leading: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            "assets/images/back_arrow.png",
            width: ScreenUtil.size22,
            height: ScreenUtil.size22,
          )
        ),
        bottom: progress >= 1.0 ? PreferredSize(child: Container()) :
        PreferredSize(
            child: SizedBox(
             child: LinearProgressIndicator(value: progress, valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary)),
              height: 3,
            )
        ),
      ),
    body: InAppWebView(
        initialUrl: widget.url,
        initialHeaders: {},
        initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              debuggingEnabled: true,
            )
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          webView = controller;
        },
        onProgressChanged: (InAppWebViewController controller, int progress) {
          setState(() {
            print("progress: $progress");
            this.progress = progress / 100;
          });
        },
      ),
    );
  }
}