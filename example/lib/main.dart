import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:ui' as ui;
import "package:pdfium_libs/pdfium_libs.dart" as pdfium_libs;

var pdfium = pdfium_libs.PdfiumWrap();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _pageLoad = false;
  void loadFile() async {
    try {
      var data =
          (await rootBundle.load('assets/test.pdf')).buffer.asUint8List();
      pdfium.loadDocumentFromBytes(data).loadPage(0);
      setState(() {
        _pageLoad = true;
      });
    } catch (e) {
      exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    loadFile();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: !_pageLoad ? CircularProgressIndicator() : PdfImage(),
      ),
    );
  }
}

class PdfImage extends StatefulWidget {
  @override
  createState() => createPdfImageState();
}

class createPdfImageState extends State<PdfImage> {
  ui.Image? _result;
  @override
  Widget build(BuildContext context) {
    renderPdf();
    return _result == null
        ? CircularProgressIndicator()
        : CustomPaint(
            painter: PdfPaint(_result!),
          );
  }

  void renderPdf() {
    var pdfList = pdfium.renderPageAsBytes(
        pdfium.getPageWidth().round(), pdfium.getPageHeight().round());
    ui.decodeImageFromPixels(pdfList, pdfium.getPageWidth().round(),
        pdfium.getPageHeight().round(), ui.PixelFormat.bgra8888, (result) {
      setState(() {
        _result = result;
      });
    }, targetWidth: 500);
  }
}

class PdfPaint extends CustomPainter {
  ui.Image? _result;
  PdfPaint(ui.Image result) {
    _result = result;
  }
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(
        _result!,
        Offset(-_result!.width / 2, -_result!.height / 2),
        Paint()..filterQuality = FilterQuality.high);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
