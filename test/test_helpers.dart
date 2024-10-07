import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> initializeSupabase() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://kgadjovnnulfhsjdpolf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtnYWRqb3ZubnVsZmhzamRwb2xmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjc5NDM4MDEsImV4cCI6MjA0MzUxOTgwMX0.dwnYbzv_UooYoIWwjFCRYUSEn-3oLHDANWp8kaR1ORM',
  );
}
