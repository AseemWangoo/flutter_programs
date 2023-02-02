import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rekognition/rekognition.dart';
import 'package:rekognition_data_source/rekognition_data_source.dart';
import 'package:test/test.dart';
import '../../routes/api/v1/rekognizeTest/index.dart' as routefirst;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockRequest extends Mock implements Request {}

class _MockUri extends Mock implements Uri {}

class _MockCelebrityDataSource extends Mock implements ImageRekognitionRepo {}

void main() {
  late RequestContext context;
  late Request request;
  late Uri uri;
  late ImageRekognitionRepo dataSource;

  final celebrityResp = [
    CelebrityModel(
      id: 'Z3He8D',
      matchConfidence: 99,
      urls: const ['www.wikidata.org/wiki/Q47213'],
      name: 'Warren Buffett',
    )
  ];

  final celebrityMap = {'data': celebrityResp};

  setUpAll(() => registerFallbackValue(celebrityResp));

  setUp(() {
    context = _MockRequestContext();
    request = _MockRequest();
    uri = _MockUri();
    dataSource = _MockCelebrityDataSource();

    // Mocking data source
    when(() => context.read<ImageRekognitionRepo>()).thenReturn(dataSource);

    when(() => context.request).thenReturn(request);
    when(() => request.uri).thenReturn(uri);

    when(() => uri.queryParameters).thenReturn({});
  });

  group('responds with a 405', () {
    test('when method is DELETE', () async {
      when(() => request.method).thenReturn(HttpMethod.delete);
      final response = await routefirst.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('when method is HEAD', () async {
      when(() => request.method).thenReturn(HttpMethod.head);
      final response = await routefirst.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('when method is OPTIONS', () async {
      when(() => request.method).thenReturn(HttpMethod.options);
      final response = await routefirst.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('when method is PATCH', () async {
      when(() => request.method).thenReturn(HttpMethod.patch);
      final response = await routefirst.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('when method is PUT', () async {
      when(() => request.method).thenReturn(HttpMethod.put);
      final response = await routefirst.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });
  });

  group('GET /rekognizeTest', () {
    test('responds with a 200 and an empty response', () async {
      when(() => dataSource.recognizeCelebrity()).thenAnswer((_) async => {});
      when(() => request.method).thenReturn(HttpMethod.get);

      final response = await routefirst.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.ok));
      expect(response.json(), completion(isEmpty));

      verify(() => dataSource.recognizeCelebrity()).called(1);
    });

    test('responds with a 200 and a celebrity response', () async {
      when(() => dataSource.recognizeCelebrity()).thenAnswer((_) async {
        return celebrityMap;
      });

      when(() => request.method).thenReturn(HttpMethod.get);

      final response = await routefirst.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.ok));
      expect(
        response.json(),
        completion({
          'data': [celebrityResp.first.toJson()]
        }),
      );

      verify(() => dataSource.recognizeCelebrity()).called(1);
    });
  });
}
