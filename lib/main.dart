import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:my_task_manager/presentation/screens/auth_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://kgadjovnnulfhsjdpolf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtnYWRqb3ZubnVsZmhzamRwb2xmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjc5NDM4MDEsImV4cCI6MjA0MzUxOTgwMX0.dwnYbzv_UooYoIWwjFCRYUSEn-3oLHDANWp8kaR1ORM',
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      home: AuthCheck(),
    );
  }
}
