import 'package:test/test.dart';
import 'package:pdfium_libs/pdfium_libs.dart' as pdfium_libs;

int LoadPdf() {
  var pdfium = pdfium_libs.PdfiumWrap();
  pdfium.loadDocumentFromPath('test.pdf');
  return (pdfium.getPageCount());
}

main() {
  test('LoadPdfTest', () {
    var count = LoadPdf();
    expect(count, 66);
  });
}
