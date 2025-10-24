import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static loadEnvironment() async {
    try {
      const fileName = '.env';
      await dotenv.load(fileName: fileName);
      print('✅ Loaded environment: $fileName');
    } catch (e) {
      print('⚠️ Failed to load evn file');
    }
  }
}
