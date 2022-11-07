import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/tipo_movimiento_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/tipo_movimiento/tipo_movimiento_repository.dart';

class TipoMovimientoUsecase {
  final TipoMovimientoRepository repository;

  TipoMovimientoUsecase(this.repository);

  Future<Either<Failure, List<TipoMovimientoEntity>>>
      getTiposMovimientosUsecase(UsuarioEntity usuario) {
    return repository.getTiposMovimientosRepository(usuario);
  }
}
