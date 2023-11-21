import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/sitio_entrega_entity.dart';

abstract class SitioEntregaRepositoryDB {
  Future<Either<Failure, List<SitioEntregaEntity>>>
      getSitiosEntregasRepositoryDB();

  Future<Either<Failure, int>> saveSitiosEntregasRepositoryDB(
      List<SitioEntregaEntity> sitioEntregaEntity);
}
