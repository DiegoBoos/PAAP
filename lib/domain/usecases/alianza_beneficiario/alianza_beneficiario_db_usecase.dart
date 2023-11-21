import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/alianza_beneficiario_entity.dart';
import '../../repositories/alianza_beneficiario/alianza_beneficiario_repository_db.dart';

class AlianzaBeneficiarioUsecaseDB {
  final AlianzaBeneficiarioRepositoryDB repositoryDB;

  AlianzaBeneficiarioUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<AlianzaBeneficiarioEntity>?>>
      getAlianzasBeneficiariosUsecaseDB(String alianzaId) {
    return repositoryDB.getAlianzasBeneficiariosRepositoryDB(alianzaId);
  }

  Future<Either<Failure, AlianzaBeneficiarioEntity?>>
      getAlianzaBeneficiarioUsecaseDB(String alianzaId, String beneficiarioId) {
    return repositoryDB.getAlianzaBeneficiarioRepositoryDB(
        alianzaId, beneficiarioId);
  }

  Future<Either<Failure, int>> saveAlianzasBeneficiariosUsecaseDB(
      List<AlianzaBeneficiarioEntity> alianzasBeneficiariosEntity) {
    return repositoryDB
        .saveAlianzasBeneficiariosRepositoryDB(alianzasBeneficiariosEntity);
  }

  Future<Either<Failure, List<AlianzaBeneficiarioEntity>>>
      getAlianzasBeneficiariosProduccionUsecaseDB() {
    return repositoryDB.getAlianzasBeneficiariosProduccionRepositoryDB();
  }

  Future<Either<Failure, int>> saveAlianzaBeneficiarioUsecaseDB(
      AlianzaBeneficiarioEntity alianzaBeneficiarioEntity) {
    return repositoryDB
        .saveAlianzaBeneficiarioRepositoryDB(alianzaBeneficiarioEntity);
  }

  Future<Either<Failure, int>> updateAlianzasBeneficiariosProduccionUsecaseDB(
      List<AlianzaBeneficiarioEntity> experienciasAgricolasEntity) {
    return repositoryDB.updateAlianzasBeneficiariosProduccionDBRepositoryDB(
        experienciasAgricolasEntity);
  }
}
