import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/meta_indicador_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/meta_indicador/meta_indicador_repository.dart';

class MetaIndicadorUsecase {
  final MetaIndicadorRepository repository;

  MetaIndicadorUsecase(this.repository);

  Future<Either<Failure, List<MetaIndicadorEntity>>> getMetasIndicadoresUsecase(
      UsuarioEntity usuario) {
    return repository.getMetasIndicadoresRepository(usuario);
  }
}
