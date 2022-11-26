import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/alianza_experiencia_pecuaria_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/alianza_experiencia_pecuaria/alianza_experiencia_pecuaria_repository.dart';
import '../../datasources/remote/alianza_experiencia_pecuaria_remote_ds.dart';

class AlianzaExperienciaPecuariaRepositoryImpl
    implements AlianzaExperienciaPecuariaRepository {
  final AlianzaExperienciaPecuariaRemoteDataSource
      alianzaExperienciaPecuariaRemoteDataSource;

  AlianzaExperienciaPecuariaRepositoryImpl(
      {required this.alianzaExperienciaPecuariaRemoteDataSource});

  @override
  Future<Either<Failure, List<AlianzaExperienciaPecuariaEntity>>>
      getAlianzasExperienciasPecuariasRepository(UsuarioEntity usuario) async {
    try {
      final alianzasExperienciasPecuarias =
          await alianzaExperienciaPecuariaRemoteDataSource
              .getAlianzasExperienciasPecuarias(usuario);

      return Right(alianzasExperienciasPecuarias);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<AlianzaExperienciaPecuariaEntity>>>
      saveAlianzasExperienciasPecuariasRepository(
          UsuarioEntity usuario,
          List<AlianzaExperienciaPecuariaEntity>
              alianzasExperienciasPecuariasEntity) async {
    try {
      final result = await alianzaExperienciaPecuariaRemoteDataSource
          .saveAlianzasExperienciasPecuarias(
              usuario, alianzasExperienciasPecuariasEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
