import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/sitio_entrega_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/sitio_entrega/sitio_entrega_repository.dart';
import '../../datasources/remote/sitio_entrega_remote_ds.dart';

class SitioEntregaRepositoryImpl implements SitioEntregaRepository {
  final SitioEntregaRemoteDataSource sitioEntregaRemoteDataSource;

  SitioEntregaRepositoryImpl({required this.sitioEntregaRemoteDataSource});

  @override
  Future<Either<Failure, List<SitioEntregaEntity>>> getSitiosEntregasRepository(
      UsuarioEntity usuario) async {
    try {
      final sitiosEntregas =
          await sitioEntregaRemoteDataSource.getSitiosEntregas(usuario);

      return Right(sitiosEntregas);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
