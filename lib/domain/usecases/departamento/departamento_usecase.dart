import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/departamento_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/departamento/departamento_repository.dart';

class DepartamentoUsecase {
  final DepartamentoRepository repository;

  DepartamentoUsecase(this.repository);

  Future<Either<Failure, List<DepartamentoEntity>>> getDepartamentosUsecase(
      UsuarioEntity usuario) {
    return repository.getDepartamentosRepository(usuario);
  }
}
