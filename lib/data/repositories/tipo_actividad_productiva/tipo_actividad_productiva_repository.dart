import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/tipo_actividad_productiva_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/tipo_actividad_productiva/tipo_actividad_productiva_repository.dart';
import '../../datasources/remote/tipo_actividad_productiva_remote_ds.dart';

class TipoActividadProductivaRepositoryImpl
    implements TipoActividadProductivaRepository {
  final TipoActividadProductivaRemoteDataSource
      tipoActividadProductivaRemoteDataSource;

  TipoActividadProductivaRepositoryImpl(
      {required this.tipoActividadProductivaRemoteDataSource});

  @override
  Future<Either<Failure, List<TipoActividadProductivaEntity>>>
      getTiposActividadesProductivasRepository(UsuarioEntity usuario) async {
    try {
      final tiposActividadesProductivas =
          await tipoActividadProductivaRemoteDataSource
              .getTiposActividadesProductivas(usuario);

      return Right(tiposActividadesProductivas);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
