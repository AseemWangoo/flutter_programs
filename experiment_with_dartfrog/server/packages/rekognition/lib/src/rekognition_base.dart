import 'dart:typed_data';

import 'package:rekognition/rekognition.dart';
import 'package:rekognition_data_source/rekognition_data_source.dart';

import '../env.dart';

class ImageRekognitionImpl implements ImageRekognitionRepo {
  final service = Rekognition(
    region: Env.regionKey,
    credentials: AwsClientCredentials(
      accessKey: Env.accessKey,
      secretKey: Env.secretkey,
    ),
  );

  @override
  Future<Map<String, List<CelebrityModel>>> recognizeCelebrity() async {
    final celebrities = await service.recognizeCelebrities(
      image: Image(
        s3Object: S3Object(
          bucket: 'test-bucket--aseem',
          name: 'wb.jpeg',
        ),
      ),
    );

    final celebritiesList = <CelebrityModel>[];
    final response = <String, List<CelebrityModel>>{};

    if (celebrities.celebrityFaces != null) {
      for (var i = 0; i < celebrities.celebrityFaces!.length; i++) {
        final celebrity = celebrities.celebrityFaces![i];

        final model = CelebrityModel(
          id: celebrity.id,
          matchConfidence: celebrity.matchConfidence,
          name: celebrity.name,
          urls: celebrity.urls,
        );

        celebritiesList.add(model);
      }

      // We should have a model for this
      response['data'] = celebritiesList;
    }

    return response;
  }

  @override
  Future<Map<String, List<CelebrityModel>>> recognizeIfCelebrity(
    Uint8List? imageBytes,
  ) async {
    final celebrities = await service.recognizeCelebrities(
      image: Image(bytes: imageBytes),
    );

    final celebritiesList = <CelebrityModel>[];
    final response = <String, List<CelebrityModel>>{};

    if (celebrities.celebrityFaces != null) {
      for (var i = 0; i < celebrities.celebrityFaces!.length; i++) {
        final celebrity = celebrities.celebrityFaces![i];

        final model = CelebrityModel(
          id: celebrity.id,
          matchConfidence: celebrity.matchConfidence,
          name: celebrity.name,
          urls: celebrity.urls,
        );

        celebritiesList.add(model);
      }

      // We should have a model for this
      response['data'] = celebritiesList;
    }

    return response;
  }
}
