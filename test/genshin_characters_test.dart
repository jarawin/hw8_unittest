import 'package:cs311hw08/genshin_characters.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'genshin_characters_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('group name', () {
    // fetch pass
    test('returns GenshinCharacters if the http call completes successfully',
        () async {
      final client = MockClient();

      when(client.get(Uri.parse('https://api.genshin.dev/characters')))
          .thenAnswer((_) async => http.Response(
              '["albedo","aloy","amber","arataki-itto","ayaka","ayato"]', 200));
      expect(await fetchCharacters(client), isA<GenshinCharacters>());
    });

    // fetch fail
    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      when(client.get(Uri.parse('https://api.genshin.dev/characters')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchCharacters(client), throwsException);
    });
  });
}
