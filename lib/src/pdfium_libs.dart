import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:pdfium_libs/src/pdfium_libs_bindings_generated.dart';
import 'dart:typed_data';

const String _libName = 'pdfium';

/// The dynamic library in which the symbols for [PdfiumLibsBindings] can be found.
final DynamicLibrary _dylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return DynamicLibrary.open('lib$_libName.dylib');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open('lib$_libName.cr.so');
  }
  if (Platform.isWindows) {
    return DynamicLibrary.open('$_libName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

/// The bindings to the native functions in [_dylib].
final PdfiumLibsBindings _bindings = PdfiumLibsBindings(_dylib);

class Pdfium {
  /// PDFium configuration
  late Pointer<FPDF_LIBRARY_CONFIG> config;
  final Allocator allocator;
  Pointer<fpdf_document_t__>? _document;
  Pointer<fpdf_page_t__>? _page;
  Pointer<Uint8>? buffer;
  Pointer<fpdf_bitmap_t__>? bitmap;
  static Pdfium? _pdfium;

  Pdfium._({this.allocator = calloc}) {
    config = allocator<FPDF_LIBRARY_CONFIG>();
    config.ref.version = 2;
    config.ref.m_pUserFontPaths = nullptr;
    config.ref.m_pIsolate = nullptr;
    config.ref.m_v8EmbedderSlot = 0;
    _bindings.FPDF_InitLibraryWithConfig(config);
  }
  @override
  factory Pdfium() {
    _pdfium ??= Pdfium._();
    return _pdfium!;
  }
}
