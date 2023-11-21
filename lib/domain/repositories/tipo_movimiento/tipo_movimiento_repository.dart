import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/tipo_movimiento_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class TipoMovimientoRepository {
  Future<Either<Failure, List<TipoMovimientoEntity>>>
      getTiposMovimientosRepository(UsuarioEntity usuario);
}
