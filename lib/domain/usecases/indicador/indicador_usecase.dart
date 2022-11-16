import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/indicador_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/indicador/indicador_repository.dart';

class IndicadorUsecase {
  final IndicadorRepository repository;

  IndicadorUsecase(this.repository);

  Future<Either<Failure, List<IndicadorEntity>>> getIndicadoresUsecase(
      UsuarioEntity usuario) {
    return repository.getIndicadoresRepository(usuario);
  }
}
