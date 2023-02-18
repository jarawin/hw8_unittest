import 'package:cs311hw08/character_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

import 'character_detail_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group("characterDetail should display widget", () {
    // case waiting
    testWidgets('CharacterDetail should display CircularProgressIndicator',
        (tester) async {
      final client = MockClient();
      when(client.get(Uri.parse('https://api.genshin.dev/characters/albedo')))
          .thenAnswer((_) async => http.Response(
              '{"name":"albedo","description":"Albedo is a 5-star Geo Catalyst character who is a playable character in Genshin Impact. He is a member of the Knights of Favonius and the leader of the Inazuma branch. He is voiced by Japanese voice actor KENN and Chinese voice actor Wang Zhiwen.","vision":"Geo","weapon":"Catalyst","rarity":5,"element":"Geo","constellation":"Albedo","image":"https://api.genshin.dev/characters/albedo.png"}',
              200));

      await tester.pumpWidget(MaterialApp(
          home: CharacterDetail(
        client: client,
        name: 'Albedo',
      )));

      final findListView = find.byType(CircularProgressIndicator);
      expect(findListView, findsOneWidget);
    });

    // case error
    testWidgets('CharacterDetail should display Text', (tester) async {
      final client = MockClient();
      when(client.get(Uri.parse('https://api.genshin.dev/characters/albedo')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      await tester.pumpWidget(MaterialApp(
          home: CharacterDetail(
        client: client,
        name: 'Albedo',
      )));
      await tester.pumpAndSettle();

      final findListView = find.byType(Text);
      expect(findListView, findsOneWidget);
    });

    // case success
    testWidgets('CharacterDetail should display a Column of characters',
        (tester) async {
      final client = MockClient();
      when(client.get(Uri.parse('https://api.genshin.dev/characters/albedo')))
          .thenAnswer((_) async => http.Response(
              '{"name":"albedo","description":"Albedo is a 5-star Geo Catalyst character who is a playable character in Genshin Impact. He is a member of the Knights of Favonius and the leader of the Inazuma branch. He is voiced by Japanese voice actor KENN and Chinese voice actor Wang Zhiwen.","vision":"Geo","weapon":"Catalyst","rarity":5,"element":"Geo","constellation":"Albedo","image":"https://api.genshin.dev/characters/albedo.png"}',
              200));
      await tester.pumpWidget(MaterialApp(
          home: CharacterDetail(
        client: client,
        name: 'Albedo',
      )));
      await tester.pumpAndSettle();
      final findListView = find.byType(Column);
      expect(findListView, findsOneWidget);
    });
  });
}
