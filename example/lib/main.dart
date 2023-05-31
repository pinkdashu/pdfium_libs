import 'package:flutter/material.dart';
import 'dart:async';

import "package:pdfium_libs/pdfium_libs.dart" as pdfium_libs;

void main() {
  var pdfium = pdfium_libs.PdfiumWrap();
  pdfium.loadDocumentFromPath('test.pdf');
  print(pdfium.getPageCount());
}
