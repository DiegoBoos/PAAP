import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/vereda_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/vereda/vereda_repository.dart';

class VeredaUsecase {
  final VeredaRepository repository;

  VeredaUsecase(this.repository);

  Future<Either<Failure, List<VeredaEntity>>> getVeredasUsecase(
      UsuarioEntity usuario) {
    return repository.getVeredasRepository(usuario);
  }
}
