import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import '../app_excaptions.dart';
import 'BaseApiServices.dart';

class NetworkApiService extends BaseApiServices {
  static const Duration _defaultTimeout = Duration(seconds: 30);

  /// GET - No headers
  @override
  Future<dynamic> getGetApiResponse(String url) async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(_defaultTimeout);
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout. Please try again');
    }
  }

  /// GET - With optional headers
  @override
  Future<dynamic> getGetApiWithHeaderResponse(
    String url, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(_defaultTimeout);
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout. Please try again');
    }
  }

  /// POST - Form data
  @override
  Future<dynamic> getPostApiResponse(String url, dynamic data) async {
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(_defaultTimeout);
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout. Please try again');
    }
  }

  /// POST - No body, optional headers
  @override
  Future<dynamic> getPostApiWithOutBodyresponse(
    String url, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http
          .post(Uri.parse(url), headers: headers)
          .timeout(_defaultTimeout);
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout. Please try again');
    }
  }

  /// POST - JSON body with optional headers
  @override
  Future<dynamic> gePostApiWithHeaderesponse(
    String url,
    dynamic data, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse(url),
            body: jsonEncode(data),
            headers: headers ?? {'Content-Type': 'application/json'},
          )
          .timeout(_defaultTimeout);
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout. Please try again');
    }
  }

  /// Image Upload (multipart)
  @override
  Future<dynamic> imagePostApiResponse(
    String url,
    Uint8List imageBytes,
    String fileName,
    String imageType, {
    Map<String, String>? headers,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      if (headers != null) request.headers.addAll(headers);
      request.fields['imageType'] = imageType;
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          imageBytes,
          filename: fileName,
          contentType: _getContentType(fileName),
        ),
      );

      var streamedResponse = await request.send().timeout(_defaultTimeout);
      var response = await http.Response.fromStream(streamedResponse);
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout. Please try again');
    }
  }

  /// PDF / Document Upload (multipart)
  @override
  Future<dynamic> documentPdfImagePostApiResponse(
    String url,
    Uint8List pdfImageBytes,
    String documentType,
    String fileName, {
    Map<String, String>? headers,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      if (headers != null) request.headers.addAll(headers);
      request.fields['documentType'] = documentType;
      request.files.add(
        http.MultipartFile.fromBytes(
          'document',
          pdfImageBytes,
          filename: fileName,
          contentType: _getContentType(fileName),
        ),
      );

      var streamedResponse = await request.send().timeout(_defaultTimeout);
      var response = await http.Response.fromStream(streamedResponse);
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout. Please try again');
    }
  }

  /// PATCH - JSON
  @override
  Future<dynamic> getPatchApiResponse(
    String url,
    dynamic data, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http
          .patch(
            Uri.parse(url),
            body: jsonEncode(data),
            headers: headers ?? {'Content-Type': 'application/json'},
          )
          .timeout(_defaultTimeout);
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout. Please try again');
    }
  }

  /// PATCH - Image without type
  @override
  Future<dynamic> getPatchApiImageResponse(
    String url,
    String fileName,
    Uint8List imageBytes, {
    Map<String, String>? headers,
  }) async {
    try {
      var request = http.MultipartRequest('PATCH', Uri.parse(url));
      if (headers != null) request.headers.addAll(headers);
      request.files.add(
        http.MultipartFile.fromBytes('logo', imageBytes, filename: fileName),
      );

      var streamedResponse = await request.send().timeout(_defaultTimeout);
      var response = await http.Response.fromStream(streamedResponse);
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout. Please try again');
    }
  }

  /// PATCH - Image with type
  @override
  Future<dynamic> getPatchApiImageCoverResponse(
    String url,
    String fileName,
    Uint8List imageBytes,
    String imageType, {
    Map<String, String>? headers,
  }) async {
    try {
      var request = http.MultipartRequest('PATCH', Uri.parse(url));
      if (headers != null) request.headers.addAll(headers);
      request.fields['imageType'] = imageType;
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          imageBytes,
          filename: fileName,
          contentType: _getContentType(fileName),
        ),
      );

      var streamedResponse = await request.send().timeout(_defaultTimeout);
      var response = await http.Response.fromStream(streamedResponse);
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout. Please try again');
    }
  }

  /// PATCH - PDF Document
  @override
  Future<dynamic> getPatchApiDocumentPDFImageResponse(
    String url,
    Uint8List pdfImageBytes,
    String documentType,
    String fileName, {
    Map<String, String>? headers,
  }) async {
    try {
      var request = http.MultipartRequest('PATCH', Uri.parse(url));
      if (headers != null) request.headers.addAll(headers);
      request.fields['documentType'] = documentType;
      request.files.add(
        http.MultipartFile.fromBytes(
          'document',
          pdfImageBytes,
          filename: fileName,
          contentType: _getContentType(fileName),
        ),
      );

      var streamedResponse = await request.send().timeout(_defaultTimeout);
      var response = await http.Response.fromStream(streamedResponse);
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout. Please try again');
    }
  }

  /// Same URL POST (alias for POST with headers)
  @override
  Future<dynamic> getsamePostApiResponse(
    String url,
    dynamic data, {
    Map<String, String>? headers,
  }) async {
    return gePostApiWithHeaderesponse(url, data, headers: headers);
  }

  /// PUT
  @override
  Future<dynamic> getPutApiResponse(
    String url,
    dynamic data, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http
          .put(
            Uri.parse(url),
            body: jsonEncode(data),
            headers: headers ?? {'Content-Type': 'application/json'},
          )
          .timeout(_defaultTimeout);
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout. Please try again');
    }
  }

  /// DELETE
  @override
  Future<dynamic> getDeleteApiResponse(
    String url, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http
          .delete(Uri.parse(url), headers: headers)
          .timeout(_defaultTimeout);
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout. Please try again');
    }
  }

  /// Helper: Get content type from file extension
  MediaType _getContentType(String fileName) {
    String extension = fileName.toLowerCase().split('.').last;
    switch (extension) {
      case 'pdf':
        return MediaType('application', 'pdf');
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpeg');
      case 'png':
        return MediaType('image', 'png');
      case 'gif':
        return MediaType('image', 'gif');
      case 'bmp':
        return MediaType('image', 'bmp');
      case 'webp':
        return MediaType('image', 'webp');
      case 'doc':
        return MediaType('application', 'msword');
      case 'docx':
        return MediaType(
          'application',
          'vnd.openxmlformats-officedocument.wordprocessingml.document',
        );
      case 'xls':
        return MediaType('application', 'vnd.ms-excel');
      case 'xlsx':
        return MediaType(
          'application',
          'vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        );
      case 'txt':
        return MediaType('text', 'plain');
      default:
        return MediaType('application', 'octet-stream');
    }
  }

  /// Parse response by status code
  dynamic _returnResponse(http.Response response) {
    final url = response.request?.url.toString() ?? 'Unknown URL';
    developer.log('🌐 URL: $url || ${response.statusCode}');
    developer.log('📦 Response: ${response.body}');

    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        return jsonDecode(response.body);
      case 409:
        throw BadRequestException(response.body.toString());
      case 500:
        throw FetchDataException('Server error');
      default:
        throw FetchDataException('Error: ${response.statusCode}');
    }
  }
}
