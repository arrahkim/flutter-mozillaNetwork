import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Detail extends StatelessWidget {
  final String url;
  Detail({@required this.url});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (_) => WebviewScaffold(
              url: url,
              appBar: AppBar(
                title: Text("Detail"),
              ),
            ),
      },
    );
  }
}
