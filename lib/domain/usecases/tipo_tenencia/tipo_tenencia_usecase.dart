import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/tipo_tenencia_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/tipo_tenencia/tipo_tenencia_repository.dart';

class TipoTenenciaUsecase {
  final TipoTenenciaRepository repository;

  TipoTenenciaUsecase(this.repository);

  Future<Either<Failure, List<TipoTenenciaEntity>>> getTiposTenenciasUsecase(
      UsuarioEntity usuario) {
    return repository.getTiposTenenciasRepository(usuario);
  }
}
