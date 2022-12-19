import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:paap/data/datasources/remote/auth_remote_ds.dart';

@GenerateMocks([
  AuthRemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
