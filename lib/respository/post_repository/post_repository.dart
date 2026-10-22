import 'package:flutter_provider_straterkit/data/network/BaseApiServices.dart';
import 'package:flutter_provider_straterkit/data/network/NetworkApiService.dart';

class PostRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  static const String baseUrl = 'https://api.starter.dev/posts';

  /// GET all posts
  Future<dynamic> getAllPosts() async {
    try {
      final response = await _apiServices.getGetApiResponse('$baseUrl/posts');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// GET single post by ID
  Future<dynamic> getPostById(int id) async {
    try {
      final response = await _apiServices.getGetApiResponse(
        '$baseUrl/posts/$id',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// POST create new post
  Future<dynamic> createPost(dynamic data) async {
    try {
      final response = await _apiServices.getPostApiResponse(
        '$baseUrl/posts',
        data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// PUT update post
  Future<dynamic> updatePost(int id, dynamic data) async {
    try {
      final response = await _apiServices.getPutApiResponse(
        '$baseUrl/posts/$id',
        data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// DELETE post
  Future<dynamic> deletePost(int id) async {
    try {
      final response = await _apiServices.getDeleteApiResponse(
        '$baseUrl/posts/$id',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
