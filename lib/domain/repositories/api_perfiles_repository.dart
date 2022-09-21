import 'package:dartz/dartz.dart';

import '../core/error/failure.dart';
import '../entities/perfil.dart';

abstract class ApiPerfilesRepository {
  Future<Either<Failure, PerfilEntity>> getPerfiles();
}
