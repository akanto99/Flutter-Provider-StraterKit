import 'dart:typed_data';

abstract class BaseApiServices {
  /// GET
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getGetApiWithHeaderResponse(
    String url, {
    Map<String, String>? headers,
  });

  /// POST
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> getPostApiWithOutBodyresponse(
    String url, {
    Map<String, String>? headers,
  });
  Future<dynamic> gePostApiWithHeaderesponse(
    String url,
    dynamic data, {
    Map<String, String>? headers,
  });

  /// Image Upload (Uint8List)
  Future<dynamic> imagePostApiResponse(
    String url,
    Uint8List imageBytes,
    String fileName,
    String imageType, {
    Map<String, String>? headers,
  });

  /// PDF / Document Upload
  Future<dynamic> documentPdfImagePostApiResponse(
    String url,
    Uint8List pdfImageBytes,
    String documentType,
    String fileName, {
    Map<String, String>? headers,
  });

  /// PATCH
  Future<dynamic> getPatchApiResponse(
    String url,
    dynamic data, {
    Map<String, String>? headers,
  });
  Future<dynamic> getPatchApiImageResponse(
    String url,
    String fileName,
    Uint8List imageBytes, {
    Map<String, String>? headers,
  });
  Future<dynamic> getPatchApiImageCoverResponse(
    String url,
    String fileName,
    Uint8List imageBytes,
    String imageType, {
    Map<String, String>? headers,
  });
  Future<dynamic> getPatchApiDocumentPDFImageResponse(
    String url,
    Uint8List pdfImageBytes,
    String documentType,
    String fileName, {
    Map<String, String>? headers,
  });

  /// Same URL POST
  Future<dynamic> getsamePostApiResponse(
    String url,
    dynamic data, {
    Map<String, String>? headers,
  });

  /// PUT
  Future<dynamic> getPutApiResponse(
    String url,
    dynamic data, {
    Map<String, String>? headers,
  });

  /// DELETE
  Future<dynamic> getDeleteApiResponse(
    String url, {
    Map<String, String>? headers,
  });
}
