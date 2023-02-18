import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cs311hw08/character_list.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'character_list_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group("charactersList should display widget", () {
    // case waiting
    testWidgets('CharacterList should display CircularProgressIndicator',
        (tester) async {
      final client = MockClient();
      when(client.get(Uri.parse('https://api.genshin.dev/characters')))
          .thenAnswer((_) async => http.Response(
              '["albedo","aloy","amber","arataki-itto","ayaka","ayato"]', 200));

      await tester.pumpWidget(MaterialApp(home: CharacterList(client: client)));

      final findListView = find.byType(CircularProgressIndicator);
      expect(findListView, findsOneWidget);
    });

    // case error
    testWidgets('CharacterList should display Text', (tester) async {
      final client = MockClient();
      when(client.get(Uri.parse('https://api.genshin.dev/characters')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      await tester.pumpWidget(MaterialApp(home: CharacterList(client: client)));
      await tester.pumpAndSettle();

      final findListView = find.byType(Text);
      expect(findListView, findsOneWidget);
    });

    // case success
    testWidgets('CharacterList should display a list of characters',
        (tester) async {
      final client = MockClient();
      when(client.get(Uri.parse('https://api.genshin.dev/characters')))
          .thenAnswer((_) async => http.Response(
              '["albedo","aloy","amber","arataki-itto","ayaka","ayato"]', 200));
      await tester.pumpWidget(MaterialApp(home: CharacterList(client: client)));
      await tester.pumpAndSettle();
      final findListView = find.byType(ListView);
      expect(findListView, findsOneWidget);
    });
  });
}
