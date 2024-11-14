import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pockemon/data/models/pockemon.dart';
import 'package:flutter_pockemon/providers/pockemon_future_provider.dart';
import 'package:flutter_pockemon/repos/hive_repo.dart';
import 'package:flutter_pockemon/repos/pockemon_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePokemonScreen extends ConsumerStatefulWidget {
  const FavoritePokemonScreen({super.key});

  @override
  ConsumerState<FavoritePokemonScreen> createState() =>
      _FavoritePokemonScreenState();
}

class _FavoritePokemonScreenState extends ConsumerState<FavoritePokemonScreen> {
  List<Pokemon> favPokemonList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() async {
      await ref
          .read(hiveRepoProvider)
          .getAllPokemonFromHive()
          .then((pokemonList) {
        log(pokemonList.length.toString());
        setState(() {
          favPokemonList = pokemonList;
        });
      });
    });
  }

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Favorites'),
  //     ),
  //     body: ListView.builder(
  //         itemCount: favPokemonList.length,
  //         itemBuilder: (context, index) {
  //           return ListTile(
  //             leading: CachedNetworkImage(
  //               imageUrl: favPokemonList[index].imageurl!,
  //               width: 50,
  //               height: 50,
  //               fit: BoxFit.cover,
  //             ),
  //             title: Text(favPokemonList[index].name!),
  //             trailing: IconButton(
  //                 onPressed: () {
  //                   ref.read(hiveRepoProvider).deletePokemonFromHive(favPokemonList[index].id!);
  //                   favPokemonList.remove(favPokemonList[index]);
  //                   setState(() {});
  //                 },
  //                 icon: const Icon(
  //                   Icons.delete,
  //                   color: Colors.red,
  //                 )),
  //           );
  //         }),
  //   );
  // }

  Widget build(BuildContext context) {
    final AsyncValue<int> counterProvider = ref.watch(counterStreamProvider(5));
    return Scaffold(
        body: counterProvider.when(data: (data) {
      return Center(child: Text(data.toString()));
    }, error: (error, stk) {
      return const Center(
        child: Text('Failed'),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }));
  }
}
