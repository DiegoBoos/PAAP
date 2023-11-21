import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';

import '../../../domain/entities/revision_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/revision/revision_repository.dart';
import '../../datasources/remote/revision_remote_ds.dart';

class RevisionRepositoryImpl implements RevisionRepository {
  final RevisionRemoteDataSource revisionRemoteDataSource;

  RevisionRepositoryImpl({required this.revisionRemoteDataSource});

  @override
  Future<Either<Failure, List<RevisionEntity>>> getRevisionesRepository(
      UsuarioEntity usuario) async {
    try {
      final revisions = await revisionRemoteDataSource.getRevisiones(usuario);

      return Right(revisions);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
