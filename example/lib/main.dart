import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;
import "package:pdfium_libs/pdfium_libs.dart" as pdfium_libs;

var pdfium = pdfium_libs.PdfiumWrap();
void main() {
  pdfium.loadDocumentFromPath('test.pdf').loadPage(0);

  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("pdfium plugin"),
      ),
      body: PdfImage(),
    ),
  ));
  print(pdfium.getPageCount());
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
    }, targetHeight: 1000);
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
        _result!, Offset.zero, Paint()..filterQuality = FilterQuality.high);
    final Rect rect = Offset.zero & size;
    const RadialGradient gradient = RadialGradient(
        center: Alignment(0.7, -0.6),
        radius: 0.2,
        colors: <Color>[Color(0xFFFFFF00), Color(0xFF0099FF)],
        stops: <double>[0.4, 1.0]);

    canvas.drawRect(
        Rect.fromLTRB(0, 0, 11.1, 10),
        Paint()
          ..color = Colors.yellow
          ..strokeWidth = 2.0
          ..strokeCap = StrokeCap.butt
          ..style = PaintingStyle.stroke);
    canvas.drawRect(
      rect,
      Paint()..shader = gradient.createShader(rect),
    );
    return;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
