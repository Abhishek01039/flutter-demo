import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:memri_example/src/config/api_config.dart';
import 'package:memri_example/src/model/post.dart';

import 'home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<List<Post>> getPosts() async {
    try {
      final Uri url = Uri.parse(EndpoingConfig.postEndpoint);
      final response = await http.get(
        url,
        headers: {
          'app-id': APIKey.apiKey,
        },
      );
      if (response.statusCode == 200) {
        final List<Post> posts = jsonDecode(response.body)['data']
            .map<Post>((e) => Post.fromJson(e as Map<String, dynamic>))
            .toList() as List<Post>;
        return posts;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}