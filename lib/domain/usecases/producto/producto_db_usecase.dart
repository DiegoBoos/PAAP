import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/producto_entity.dart';
import '../../repositories/producto/producto_repository_db.dart';

class ProductoUsecaseDB {
  final ProductoRepositoryDB repositoryDB;

  ProductoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<ProductoEntity>?>> getProductoUsecaseDB() {
    return repositoryDB.getProductosRepositoryDB();
  }

  Future<Either<Failure, int>> saveProductoUsecaseDB(
      List<ProductoEntity> productos) {
    return repositoryDB.saveProductosRepositoryDB(productos);
  }
}
