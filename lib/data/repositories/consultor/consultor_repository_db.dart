import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';

import '../../../domain/entities/consultor_entity.dart';
import '../../../domain/repositories/consultor/consultor_repository_db.dart';
import '../../datasources/local/consultor_local_ds.dart';

class ConsultorRepositoryDBImpl implements ConsultorRepositoryDB {
  final ConsultorLocalDataSource consultorLocalDataSource;

  ConsultorRepositoryDBImpl({required this.consultorLocalDataSource});

  @override
  Future<Either<Failure, List<ConsultorEntity>>>
      getConsultoresRepositoryDB() async {
    try {
      final consultoresDB = await consultorLocalDataSource.getConsultoresDB();

      return Right(consultoresDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, ConsultorEntity?>> getConsultorRepositoryDB(
      String id) async {
    try {
      final consultorDB = await consultorLocalDataSource.getConsultorDB(id);

      return Right(consultorDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveConsultoresRepositoryDB(
      List<ConsultorEntity> consultorEntity) async {
    try {
      final consultorDB =
          await consultorLocalDataSource.saveConsultores(consultorEntity);
      return Right(consultorDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
