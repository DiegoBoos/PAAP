import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:paap/data/datasources/remote/aliado_remote_ds.dart';
import 'package:paap/data/datasources/remote/alianza_beneficiario_remote_ds.dart';

@GenerateMocks([AliadoRemoteDataSource, AlianzaBeneficiarioRemoteDataSource],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {}
