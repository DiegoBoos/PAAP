import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/beneficio_entity.dart';
import '../../../domain/repositories/beneficio/beneficio_repository_db.dart';
import '../../datasources/local/beneficio_local_ds.dart';

class BeneficioRepositoryDBImpl implements BeneficioRepositoryDB {
  final BeneficioLocalDataSource beneficioLocalDataSource;

  BeneficioRepositoryDBImpl({required this.beneficioLocalDataSource});

  @override
  Future<Either<Failure, List<BeneficioEntity>>>
      getBeneficiosRepositoryDB() async {
    try {
      final beneficiosDB = await beneficioLocalDataSource.getBeneficiosDB();

      return Right(beneficiosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveBeneficiosRepositoryDB(
      List<BeneficioEntity> beneficioEntity) async {
    try {
      final beneficioDB =
          await beneficioLocalDataSource.saveBeneficios(beneficioEntity);
      return Right(beneficioDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
