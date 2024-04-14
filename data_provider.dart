import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DataProvider extends ChangeNotifier {
  List<dynamic> _pokemons = [];
  bool _isLoading = true;
  String? _error;
   bool get hasError => error != null;

  List<dynamic> get pokemons => _pokemons;
  bool get isLoading => _isLoading;
  String? get error => _error;

  DataProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    const url = 'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
        _pokemons = json['pokemon'];
        _isLoading = false;
      } else {
        _error = 'Failed to load data. Error: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Failed to fetch data. Error: $e';
    } finally {
      notifyListeners();
    }
  }
}
