import 'dart:convert';
import 'dart:developer';

import 'package:flutter_pockemon/network/dio_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/pockemon.dart';
import '../utils/helpers/constants.dart';

class PockemonRepo {
  final Ref ref;

  PockemonRepo(this.ref);

  Future<List<Pokemon>> getAllProducts() async {
    try {
      final response = await ref.read(dioProvider).get(POKEMON_API_URL);
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.data);
        final List<Pokemon> pockemonList = decodedJson
            .map<Pokemon>((pokemon) => Pokemon.PokemonFromJson(pokemon))
            .toList();
        log(pockemonList.toString());
        return pockemonList;
      } else {
        throw Exception('Failed to load pockemons');
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}

final pockemonRepoProvider = Provider<PockemonRepo>((ref) => PockemonRepo(ref));
