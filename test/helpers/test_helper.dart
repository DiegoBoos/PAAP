import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:paap/app_config.dart';
import 'package:paap/data/utils.dart';

@GenerateMocks([], customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {
  final appConfig = AppConfig.devAppConfig;
  Utils.setAppConfig(appConfig);
}
