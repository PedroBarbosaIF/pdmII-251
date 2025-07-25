import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/anime.dart';

class AnimeService {
  static const String _baseUrl = 'https://api.jikan.moe/v4/top/anime';

  Future<List<Anime>> fetchAnimes() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {'Accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['data'];
        return results.map((json) => Anime.fromJson(json)).toList();
      } else {
        throw Exception('Falha ao carregar: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na conexão: $e');
    }
  }
}
