import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sdk/components/network_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xml/xml.dart';

class WebViewScreen extends StatefulWidget {
  final url;
  final code;
  final void Function(bool, String, String) onResponse;

  WebViewScreen(
      {@required this.url, @required this.code, @required this.onResponse});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  String _url = '';
  String _code = '';
  bool _showLoader = false;
  bool _showedOnce = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _url = widget.url;
    _code = widget.code;
    print('url in webview $_url, $_code');
  }

  void complete(XmlDocument xml) async {
    setState(() {
      _showLoader = true;
    });
    NetworkHelper _networkHelper = NetworkHelper();
    var response = await _networkHelper.completed(xml);
    print(response);
    if (response == 'failed' || response == null) {
      alertShow('Failed. Please try again', false);
      setState(() {
        _showLoader = false;
      });
    } else {
      final doc = XmlDocument.parse(response);
      final message = doc.findAllElements('message').map((node) => node.text);
      if (message.toString().length > 2) {
        String msg = message.toString();
        msg = msg.replaceAll('(', '');
        msg = msg.replaceAll(')', '');
        setState(() {
          _showLoader = false;
        });

        final statusCandidates = doc.findAllElements('status').toList();
        bool isSuccess = false;
        String errorMsg;

        if (statusCandidates.isNotEmpty) {
          isSuccess = statusCandidates.first.text == 'A' ||
              statusCandidates.first.text == 'H';

          if (!isSuccess || statusCandidates.first.text == 'H') {
            final messageCandidates = doc.findAllElements('message').toList();

            if (messageCandidates.isNotEmpty &&
                messageCandidates.first.text.isNotEmpty) {
              errorMsg = messageCandidates.first.text;

              if (!_showedOnce &&
                  errorMsg != null &&
                  errorMsg.isNotEmpty) {
                _showedOnce = true;
                alertShow(messageCandidates.first.text, true);
              }
            }
          }
        }

        widget.onResponse(
          isSuccess,
          doc.toString(),
          errorMsg,
        );
        // https://secure.telr.com/gateway/webview_start.html?code=a8caa483fe7260ace06a255cc32e
      }
    }
  }

  void alertShow(String text, bool pop) {
    print('popup thrown');

    showPlatformDialog(
      context: context,
      builder: (_) => BasicDialogAlert(
        title: Text(
          '$text',
          style: TextStyle(fontSize: 15),
        ),
        // content: Text('$text Please try again.'),
        actions: <Widget>[
          BasicDialogAction(
              title: Text('Ok'),
              onPressed: () {
                print(pop.toString());
                if (pop) {
                  print('inside pop');
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else {
                  print('inside false');
                  Navigator.pop(context);
                }
              }),
        ],
      ),
    );
  }

  void createXml() {
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.element('mobile', nest: () {
      builder.element('store', nest: () {
        builder.text('26550');
      });
      builder.element('key', nest: () {
        builder.text('9F2sv-N8hFS@zKdS');
      });
      builder.element('complete', nest: () {
        builder.text(_code);
      });
    });

    final bookshelfXml = builder.buildDocument();
    print(bookshelfXml);
    complete(bookshelfXml);
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showLoader,
      color: Colors.white,
      opacity: 0.5,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            // brightness: Brightness.light,
            title: Text(
              'Payment',
              style: TextStyle(color: Colors.black),
            ),
            leading: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ),
          body: WebView(
            initialUrl: _url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            navigationDelegate: (NavigationRequest request) {
              print('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
              _showedOnce = false;
              if (url.contains('close')) {
                print('call the api');
              }
              if (url.contains('abort')) {
                print('show fail and pop');
              }
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
              if (url.contains('close')) {
                print('call the api');
                createXml();
              }
              if (url.contains('abort')) {
                print('show fail and pop');
              }
            },
            gestureNavigationEnabled: true,
          )),
    );
  }
}
