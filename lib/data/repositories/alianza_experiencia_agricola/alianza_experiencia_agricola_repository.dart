import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';

import '../../../domain/entities/alianza_experiencia_agricola_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/alianza_experiencia_agricola/alianza_experiencia_agricola_repository.dart';
import '../../datasources/remote/alianza_experiencia_agricola_remote_ds.dart';

class AlianzaExperienciaAgricolaRepositoryImpl
    implements AlianzaExperienciaAgricolaRepository {
  final AlianzaExperienciaAgricolaRemoteDataSource
      alianzaExperienciaAgricolaRemoteDataSource;

  AlianzaExperienciaAgricolaRepositoryImpl(
      {required this.alianzaExperienciaAgricolaRemoteDataSource});

  @override
  Future<Either<Failure, List<AlianzaExperienciaAgricolaEntity>>>
      getAlianzasExperienciasAgricolasRepository(UsuarioEntity usuario) async {
    try {
      final alianzasExperienciasAgricolas =
          await alianzaExperienciaAgricolaRemoteDataSource
              .getAlianzasExperienciasAgricolas(usuario);

      return Right(alianzasExperienciasAgricolas);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<AlianzaExperienciaAgricolaEntity>>>
      saveAlianzasExperienciasAgricolasRepository(
          UsuarioEntity usuario,
          List<AlianzaExperienciaAgricolaEntity>
              alianzasExperienciasAgricolasEntity) async {
    try {
      final result = await alianzaExperienciaAgricolaRemoteDataSource
          .saveAlianzasExperienciasAgricolas(
              usuario, alianzasExperienciasAgricolasEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
