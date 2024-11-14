import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pockemon/data/models/pockemon.dart';
import 'package:flutter_pockemon/repos/hive_repo.dart';
import 'package:flutter_pockemon/ui/widgets/rotating_widget.dart';
import 'package:flutter_pockemon/utils/extentions/build_context_extensions.dart';
import 'package:flutter_pockemon/utils/helpers/helpers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailPokemonScreen extends ConsumerStatefulWidget {
  const DetailPokemonScreen({super.key, required this.pockemon});

  final Pokemon pockemon;
  @override
  ConsumerState<DetailPokemonScreen> createState() =>
      _DetailPokemonScreenState();
}

class _DetailPokemonScreenState extends ConsumerState<DetailPokemonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Helpers.getPokemonCardColour(
          pokemonType: widget.pockemon.typeofpokemon!.first),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        title: Text(
          widget.pockemon.name!,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(hiveRepoProvider).addPokemonToHive(widget.pockemon);
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.white,
              ))
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: context.getWidth(percentage: 0.5) - 125,
            top: 50,
            child: const RotatingImageWidget(),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              height: context.getHeight(percentage: 0.58),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(widget.pockemon.xdescription!),
                    PokemonDetail(
                        title: 'Type',
                        data: widget.pockemon.typeofpokemon!.join(',')),
                    PokemonDetail(
                        title: 'Height', data: widget.pockemon.height!),
                    PokemonDetail(
                        title: 'Weigth', data: widget.pockemon.weight!),
                    PokemonDetail(
                        title: 'Speed',
                        data: widget.pockemon.speed!.toString()),
                    PokemonDetail(
                        title: 'Attack',
                        data: widget.pockemon.attack!.toString()),
                    PokemonDetail(
                        title: 'Defense',
                        data: widget.pockemon.defense!.toString()),
                    PokemonDetail(
                        title: 'Weakness',
                        data: widget.pockemon.weaknesses!.toString()),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: context.getWidth(percentage: 0.5) - 125,
            top: 50,
            child: Hero(
              tag: widget.pockemon.id!,
              child: CachedNetworkImage(
                imageUrl: widget.pockemon.imageurl!,
                width: 250,
                fit: BoxFit.fitWidth,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PokemonDetail extends StatelessWidget {
  const PokemonDetail({super.key, required this.title, required this.data});

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: context.getWidth(percentage: 0.2),
        ),
        Text(data)
      ],
    );
  }
}
