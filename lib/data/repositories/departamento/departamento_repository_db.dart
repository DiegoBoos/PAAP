import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/departamento_entity.dart';
import '../../../domain/repositories/departamento/departamento_repository_db.dart';
import '../../datasources/local/departamento/departamento_local_ds.dart';

class DepartamentoRepositoryDBImpl implements DepartamentoRepositoryDB {
  final DepartamentoLocalDataSource departamentoLocalDataSource;

  DepartamentoRepositoryDBImpl({required this.departamentoLocalDataSource});

  @override
  Future<Either<Failure, List<DepartamentoEntity>>>
      getDepartamentosRepositoryDB() async {
    try {
      final departamentosDB =
          await departamentoLocalDataSource.getDepartamentosDB();

      return Right(departamentosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveDepartamentosRepositoryDB(
      List<DepartamentoEntity> departamentoEntity) async {
    try {
      final departamentoDB = await departamentoLocalDataSource
          .saveDepartamentos(departamentoEntity);
      return Right(departamentoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
