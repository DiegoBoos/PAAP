import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/meta_indicador_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/meta_indicador/meta_indicador_repository.dart';
import '../../datasources/remote/meta_indicador_remote_ds.dart';

class MetaIndicadorRepositoryImpl implements MetaIndicadorRepository {
  final MetaIndicadorRemoteDataSource metaIndicadorRemoteDataSource;

  MetaIndicadorRepositoryImpl({required this.metaIndicadorRemoteDataSource});

  @override
  Future<Either<Failure, List<MetaIndicadorEntity>>>
      getMetasIndicadoresRepository(UsuarioEntity usuario) async {
    try {
      final metasIndicadores =
          await metaIndicadorRemoteDataSource.getMetasIndicadores(usuario);

      return Right(metasIndicadores);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
