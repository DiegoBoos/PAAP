import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/tipo_movimiento_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/tipo_movimiento/tipo_movimiento_repository.dart';
import '../../datasources/remote/tipo_movimiento/tipo_movimiento_remote_ds.dart';

class TipoMovimientoRepositoryImpl implements TipoMovimientoRepository {
  final TipoMovimientoRemoteDataSource tipoMovimientoRemoteDataSource;

  TipoMovimientoRepositoryImpl({required this.tipoMovimientoRemoteDataSource});

  @override
  Future<Either<Failure, List<TipoMovimientoEntity>>>
      getTiposMovimientosRepository(UsuarioEntity usuario) async {
    try {
      final tipomovimientos =
          await tipoMovimientoRemoteDataSource.getTiposMovimientos(usuario);

      return Right(tipomovimientos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
