import 'package:flutter_pockemon/data/models/pockemon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveRepo {
  final pokemonBoxName = 'PokemonBox';

  void registerAdapter() {
    Hive.registerAdapter(PokemonAdapter());
  }

  Future addPokemonToHive(Pokemon pokemon) async {
    final pokemonBox = await Hive.openBox<Pokemon>(pokemonBoxName);

    if (pokemonBox.isOpen) {
      await pokemonBox.put(pokemon.id!, pokemon);
      pokemonBox.close();
    } else {
      throw Exception('Box is not open');
    }
  }

  Future deletePokemonFromHive(String id) async {
    final pokemonBox = await Hive.openBox<Pokemon>(pokemonBoxName);
    if (pokemonBox.isOpen) {
      pokemonBox.delete(id);
    } else {
      throw Exception('Box is not open');
    }
  }

  Future<List<Pokemon>> getAllPokemonFromHive() async {
    final pokemonBox = await Hive.openBox<Pokemon>(pokemonBoxName);
    if (pokemonBox.isOpen) {
      return pokemonBox.values.toList();
    } else {
      throw Exception('Box is not open');
    }
  }

  Future<Pokemon> getSinglePokemonFromHive(String id) async {
    final pokemonBox = await Hive.openBox<Pokemon>(pokemonBoxName);
    if (pokemonBox.isOpen) {
      return pokemonBox.get(id)!;
    } else {
      throw Exception('Box is not open');
    }
  }
}

final hiveRepoProvider = Provider<HiveRepo>((ref) => HiveRepo());
