import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:rekognition_data_source/rekognition_data_source.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  final method = context.request.method;

  if (method == HttpMethod.get) {
    return _get(context);
  }

  return Response(statusCode: HttpStatus.methodNotAllowed);
}

Future<Response> _get(RequestContext context) async {
  final dataSource = context.read<ImageRekognitionRepo>();
  final celebrities = await dataSource.recognizeCelebrity();

  return Response.json(body: celebrities);
}
