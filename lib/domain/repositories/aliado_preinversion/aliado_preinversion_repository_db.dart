import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/aliado_preinversion_entity.dart';

abstract class AliadoPreinversionRepositoryDB {
  Future<Either<Failure, List<AliadoPreinversionEntity>>>
      getAliadosPreinversionRepositoryDB();

  Future<Either<Failure, AliadoPreinversionEntity?>>
      getAliadoPreinversionRepositoryDB(String id);

  Future<Either<Failure, int>> saveAliadosPreinversionRepositoryDB(
      List<AliadoPreinversionEntity> aliadopreinversionEntity);
}
