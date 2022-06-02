import 'package:flutter/material.dart';
import 'package:elgawda_by_shay_b_haleb_new/secreens/wrapper/wrapper.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class PaymentMethod extends StatefulWidget {
  final String? url;

  const PaymentMethod({Key? key, this.url}) : super(key: key);
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: new AppBar(
        title: const Text('Payment Method'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => Wrapper()),
              (route) => false,
            );
          },
        ),
      ),
      url: widget.url!,
      withJavascript: true,
      supportMultipleWindows: true,
      withLocalStorage: true,
      allowFileURLs: true,
      enableAppScheme: true,
      appCacheEnabled: true,
      hidden: false,
      scrollBar: true,
      geolocationEnabled: false,
      clearCookies: true,
    );
  }
}
