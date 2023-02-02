import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'accesskey')
  static final accessKey = _Env.accessKey;

  @EnviedField(varName: 'secretkey')
  static final secretkey = _Env.secretkey;

  @EnviedField(varName: 'regionkey')
  static final regionKey = _Env.regionKey;
}
