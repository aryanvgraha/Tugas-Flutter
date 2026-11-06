import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post.dart';

class ApiService {
  // Ganti dengan URL Gist Raw terbaru yang baru saja Anda buat
  static const String apiUrl =
      'https://gist.githubusercontent.com/aryanvgraha/9aa0b4ffc9eae60b3c094543813978bc/raw/a1b4cec251e0a9df6e3310ad99686ef89ad744be/kampus.json';

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat (${response.statusCode})');
    }
  }
}
