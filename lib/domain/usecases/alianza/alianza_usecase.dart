import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/alianza_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/alianza/alianza_repository.dart';

class AlianzaUsecase {
  final AlianzaRepository repository;

  AlianzaUsecase(this.repository);

  Future<Either<Failure, List<AlianzaEntity>>> getAlianzasUsecase(
      UsuarioEntity usuario) {
    return repository.getAlianzasRepository(usuario);
  }
}
