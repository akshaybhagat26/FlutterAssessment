import 'package:flutter/material.dart';
import 'package:flutter_pockemon/repos/hive_repo.dart';
import 'package:flutter_pockemon/repos/them_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'themes/styles.dart';
import 'ui/screens/all_pockemon_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  HiveRepo().registerAdapter();

  runApp(const ProviderScope(child: HomeScreen()));
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async  {
     await ref.read(themeProvider.notifier).addTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = ref.watch(themeProvider);
    return MaterialApp(
      theme: Styles.themeData(isDarkTheme: isDarkTheme),
      home: const AllPockemonScreen(),
    );
  }
}
