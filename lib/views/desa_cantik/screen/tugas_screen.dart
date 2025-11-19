import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DesaTugasPage extends StatefulWidget {
  const DesaTugasPage({super.key});

  @override
  State<DesaTugasPage> createState() => _DesaTugasPageState();
}

class _DesaTugasPageState extends State<DesaTugasPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(
          "https://docs.google.com/forms/d/e/1FAIpQLSdXXXXXXXXX/viewform",
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tugas Desa Cantik",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFFF8A00),
        centerTitle: true,
        elevation: 0,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
