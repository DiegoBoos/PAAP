import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/aliado_preinversion_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/aliado_preinversion/aliado_preinversion_repository.dart';
import '../../datasources/remote/aliado_preinversion/aliado_preinversion_remote_ds.dart';

class AliadoPreinversionRepositoryImpl implements AliadoPreinversionRepository {
  final AliadoPreinversionRemoteDataSource aliadoPreinversionRemoteDataSource;

  AliadoPreinversionRepositoryImpl(
      {required this.aliadoPreinversionRemoteDataSource});

  @override
  Future<Either<Failure, List<AliadoPreinversionEntity>>>
      getAliadosPreinversionRepository(UsuarioEntity usuario) async {
    try {
      final aliadosPreinversion = await aliadoPreinversionRemoteDataSource
          .getAliadosPreinversion(usuario);

      return Right(aliadosPreinversion);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
