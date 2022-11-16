import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/producto_objetivo_entity.dart';
import '../../repositories/producto_objetivo/producto_objetivo_repository_db.dart';

class ProductoObjetivoUsecaseDB {
  final ProductoObjetivoRepositoryDB repositoryDB;

  ProductoObjetivoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<ProductoObjetivoEntity>?>>
      getProductosObjetivosUsecaseDB() {
    return repositoryDB.getProductosObjetivosRepositoryDB();
  }

  Future<Either<Failure, int>> saveProductosObjetivosUsecaseDB(
      List<ProductoObjetivoEntity> producto_ObjetivoEntity) {
    return repositoryDB
        .saveProductosObjetivosRepositoryDB(producto_ObjetivoEntity);
  }
}
