import 'package:flutter_pockemon/data/models/pockemon.dart';
import 'package:flutter_pockemon/repos/pockemon_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pockemonFutureProvider = FutureProvider<List<Pokemon>>((ref) async {
  return await ref.watch(pockemonRepoProvider).getAllProducts();
});

final counterStreamProvider =
    StreamProvider.autoDispose.family<int, int>((ref, counterStart) async* {
  int counter = counterStart;
  while (counter > 20) {
    await Future.delayed(const Duration(milliseconds: 500));
    yield counter++;
  }
});
