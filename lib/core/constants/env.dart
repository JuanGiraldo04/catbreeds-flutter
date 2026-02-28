import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'CAT_API_KEY', obfuscate: true)
  static final String apiKey = _Env.apiKey;
}
