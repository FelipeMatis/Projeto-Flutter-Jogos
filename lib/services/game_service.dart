import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/game_model.dart';

class GameService {
  static const String _baseUrl = 'https://www.freetogame.com/api/games';

  // 1. Consumo da API de Jogos
  static Future<List<Game>> fetchGames({String? customEndpoint}) async {
    final url = Uri.parse(customEndpoint ?? _baseUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((item) => Game.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar jogos da API: ${response.statusCode}');
    }
  }

  // 2. Mapeamento direto de GIFs específicos para os principais títulos
  static final Map<String, String> _gameGifs = {
    'overwatch': 'https://media.giphy.com/media/l0HlOBZRezrw2xgmc/giphy.gif',
    'counter-strike': 'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExOHIyb2N4cTBsZnVyMmhkc3g4dmlycmVudXRqNHJldHF2OW5vOTJqMyZlcD12MV9naWZzX3NlYXJjaCZjdD1n/rTAVMVAps9zsFINvxI/giphy.gif',
    'pubg': 'https://media.giphy.com/media/3ov9jOJSQhGCrizUWA/giphy.gif',
    'diablo': 'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExYnJ2dnJyd3BsbHRseG5uNzl3N3phc3Vnbmp5cXR2MWZ1M240dnpxNyZlcD12MV9naWZzX3NlYXJjaCZjdD1n/WprEJQOAkJHz2/giphy.gif',
    'valorant': 'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExOHIyb2N4cTBsZnVyMmhkc3g4dmlycmVudXRqNHJldHF2OW5vOTJqMyZlcD12MV9naWZzX3NlYXJjaCZjdD1n/rTAVMVAps9zsFINvxI/giphy.gif',
    'genshin': 'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExYnJ2dnJyd3BsbHRseG5uNzl3N3phc3Vnbmp5cXR2MWZ1M240dnpxNyZlcD12MV9naWZzX3NlYXJjaCZjdD1n/WprEJQOAkJHz2/giphy.gif',
    'warframe': 'https://media.giphy.com/media/l41lI4bYmcsPJX9Go/giphy.gif',
  };

  // Mapeamento de GIFs por categoria para os demais jogos
  static final Map<String, String> _genreGifs = {
    'shooter': 'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExOHIyb2N4cTBsZnVyMmhkc3g4dmlycmVudXRqNHJldHF2OW5vOTJqMyZlcD12MV9naWZzX3NlYXJjaCZjdD1n/rTAVMVAps9zsFINvxI/giphy.gif',
    'rpg': 'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExYnJ2dnJyd3BsbHRseG5uNzl3N3phc3Vnbmp5cXR2MWZ1M240dnpxNyZlcD12MV9naWZzX3NlYXJjaCZjdD1n/WprEJQOAkJHz2/giphy.gif',
    'mmorpg': 'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExYnJ2dnJyd3BsbHRseG5uNzl3N3phc3Vnbmp5cXR2MWZ1M240dnpxNyZlcD12MV9naWZzX3NlYXJjaCZjdD1n/WprEJQOAkJHz2/giphy.gif',
    'strategy': 'https://media.giphy.com/media/26FPJGjhefSJuaRhu/giphy.gif',
    'fighting': 'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbmZlc2I1OGNmdWFxazU1bnRwOWJrcHBwOG8zZzN2bmFydDF3MXpmZyZlcD12MV9naWZzX3NlYXJjaCZjdD1n/3lFHsrveDaK5q/giphy.gif',
    'racing': 'https://media.giphy.com/media/3ov9jOJSQhGCrizUWA/giphy.gif',
  };

  static Future<String> fetchGameGif(String title, String genre) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final normalizedTitle = title.toLowerCase();
    for (var entry in _gameGifs.entries) {
      if (normalizedTitle.contains(entry.key)) {
        return entry.value;
      }
    }

    final normalizedGenre = genre.toLowerCase();
    for (var entry in _genreGifs.entries) {
      if (normalizedGenre.contains(entry.key)) {
        return entry.value;
      }
    }

    return 'https://media.giphy.com/media/l41lI4bYmcsPJX9Go/giphy.gif';
  }
}
