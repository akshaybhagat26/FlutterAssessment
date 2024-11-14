import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pockemon/data/models/pockemon.dart';
import 'package:flutter_pockemon/ui/screens/detail_pokemon_screen.dart';
import 'package:flutter_pockemon/utils/extentions/build_context_extensions.dart';
import 'package:flutter_pockemon/utils/helpers/helpers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/pockemon_future_provider.dart';
import '../../repos/them_repo.dart';
import 'favorite_pokemon_screen.dart';

class AllPockemonScreen extends ConsumerWidget {
  const AllPockemonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Pokemon>> pockemonList =
        ref.watch(pockemonFutureProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () {
                context.navigateToScreen(const FavoritePokemonScreen());
              },
              icon: const Icon(Icons.favorite)),
          IconButton(
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
              icon: const Icon(Icons.lightbulb))
        ],
      ),
      body: pockemonList.when(data: (data) {
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2 / 2),
            itemBuilder: (contex, index) {
              return InkWell(
                onTap: () {
                  contex.navigateToScreen(
                      DetailPokemonScreen(pockemon: data[index]));
                },
                child: Card(
                  color: Helpers.getPokemonCardColour(
                      pokemonType: data[index].typeofpokemon!.first),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -10,
                        bottom: -10,
                        child: Image.asset('images/pokeball.png',
                            height: 150, fit: BoxFit.cover),
                      ),
                      Positioned(
                        right: -10,
                        bottom: -10,
                        child: Hero(
                          tag: data[index].id!,
                          child: CachedNetworkImage(
                            imageUrl: data[index].imageurl!,
                            height: 150,
                            fit: BoxFit.cover,
                            placeholder: (contex, url) => (const Center(
                              child: CircularProgressIndicator(),
                            )),
                            errorWidget: (context, url, error) =>
                                (const Icon(Icons.error)),
                          ),
                        ),
                      ),
                      Positioned(
                          left: 10,
                          top: 10,
                          child: Text(
                            data[index].name!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                      Positioned(
                          left: 10,
                          top: 40,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Text(
                                  data[index].typeofpokemon!.first,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              );
            });
      }, error: (error, stk) {
        return Center(
          child: Text(error.toString()),
        );
      }, loading: () {
        return const Center(
          child: Text('Failed to load pockemon list'),
        );
      }),
    );
  }
}
