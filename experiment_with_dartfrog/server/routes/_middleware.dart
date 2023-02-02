import 'package:dart_frog/dart_frog.dart';

import 'package:rekognition/rekognition.dart';
import 'package:rekognition_data_source/rekognition_data_source.dart';

final _dataSource = ImageRekognitionImpl();

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(provider<ImageRekognitionRepo>((_) => _dataSource));
}
