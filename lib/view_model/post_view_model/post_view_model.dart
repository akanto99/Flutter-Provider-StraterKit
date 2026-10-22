import 'package:flutter/foundation.dart';
import 'package:flutter_provider_straterkit/data/response/api_response.dart';
import 'package:flutter_provider_straterkit/model/post/post_model.dart';
import 'package:flutter_provider_straterkit/respository/post_repository/post_repository.dart';

class PostViewModel with ChangeNotifier {
  final _postRepo = PostRepository();

  ApiResponse<List<PostModel>> postList = ApiResponse.loading();
  ApiResponse<PostModel> singlePost = ApiResponse.loading();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  /// Fetch all posts
  Future<void> fetchAllPosts() async {
    postList = ApiResponse.loading();
    notifyListeners();

    try {
      final response = await _postRepo.getAllPosts();
      final List<PostModel> posts = (response as List)
          .map((json) => PostModel.fromJson(json))
          .toList();
      postList = ApiResponse.completed(posts);
      notifyListeners();
    } catch (error) {
      if (kDebugMode) print('Error fetching posts: $error');
      postList = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }

  /// Fetch single post by ID
  Future<void> fetchPostById(int id) async {
    singlePost = ApiResponse.loading();
    notifyListeners();

    try {
      final response = await _postRepo.getPostById(id);
      final post = PostModel.fromJson(response);
      singlePost = ApiResponse.completed(post);
      notifyListeners();
    } catch (error) {
      if (kDebugMode) print('Error fetching post: $error');
      singlePost = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }

  /// Create new post
  Future<bool> createPost(PostModel post) async {
    setLoading(true);
    try {
      final data = {
        'userId': post.userId.toString(),
        'title': post.title,
        'body': post.body,
      };
      await _postRepo.createPost(data);
      setLoading(false);
      return true;
    } catch (error) {
      if (kDebugMode) print('Error creating post: $error');
      setLoading(false);
      return false;
    }
  }

  /// Update post
  Future<bool> updatePost(int id, PostModel post) async {
    setLoading(true);
    try {
      final data = {
        'userId': post.userId.toString(),
        'title': post.title,
        'body': post.body,
      };
      await _postRepo.updatePost(id, data);
      setLoading(false);
      return true;
    } catch (error) {
      if (kDebugMode) print('Error updating post: $error');
      setLoading(false);
      return false;
    }
  }

  /// Delete post
  Future<bool> deletePost(int id) async {
    setLoading(true);
    try {
      await _postRepo.deletePost(id);
      setLoading(false);
      return true;
    } catch (error) {
      if (kDebugMode) print('Error deleting post: $error');
      setLoading(false);
      return false;
    }
  }
}
