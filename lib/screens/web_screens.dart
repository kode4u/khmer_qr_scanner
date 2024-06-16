import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatefulWidget {
  String url;

  WebScreen(this.url);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  WebViewController? controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'app_name'.tr,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed('/setting');
              },
              icon: const Icon(
                CupertinoIcons.settings,
                color: Colors.white,
              ))
        ],
      ),
      body: Stack(
        children: [
          //KAppBarMenu(isEnglish: S.isEn(context),),
          Container(
            margin: const EdgeInsets.only(top: 0),
            child: WebViewWidget(
              controller: controller!,
            ),
          ),
        ],
      ),
    ));
  }
}
