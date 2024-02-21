import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restapi_retrofit/models/post_model.dart';
import 'package:restapi_retrofit/service/api_service.dart';

class PostController extends ChangeNotifier {
  final ApiService apiService =
      ApiService(Dio(BaseOptions(contentType: "application/json")));
  List<PostModel> posts = [];

  Future<void> fetchPosts() async {
    try {
      posts = await apiService.getPosts();
      // Check if posts are fetched
      log("Fetched ${posts.length} posts");
    } catch (e) {
      // Handle errors
      log("Error fetching posts: $e");
    }
    notifyListeners();
  }
}
