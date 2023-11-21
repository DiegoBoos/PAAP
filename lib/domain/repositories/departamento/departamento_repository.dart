import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/departamento_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class DepartamentoRepository {
  Future<Either<Failure, List<DepartamentoEntity>>> getDepartamentosRepository(
      UsuarioEntity usuario);
}
