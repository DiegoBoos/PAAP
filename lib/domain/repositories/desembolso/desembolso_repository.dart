import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/desembolso_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class DesembolsoRepository {
  Future<Either<Failure, List<DesembolsoEntity>>> getDesembolsosRepository(
      UsuarioEntity usuario);
}
