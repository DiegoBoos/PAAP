import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/alianza_beneficiario_entity.dart';
import '../../../domain/db/db_config.dart';
import '../../models/alianza_beneficiario_model.dart';

abstract class AlianzaBeneficiarioLocalDataSource {
  Future<List<AlianzaBeneficiarioModel>> getAlianzasBeneficiariosDB();
  Future<List<AlianzaBeneficiarioModel>> getAlianzasBeneficiariosProduccionDB();
  Future<AlianzaBeneficiarioModel?> getAlianzaBeneficiarioDB(
      String alianzaId, String beneficiarioId);
  Future<int> saveAlianzasBeneficiarios(
      List<AlianzaBeneficiarioEntity> alianzaBeneficiarioEntity);
  Future<int> saveAlianzaBeneficiarioDB(
      AlianzaBeneficiarioEntity alianzaBeneficiarioEntity);
  Future<int> updateAlianzasBeneficiariosProduccionDB(
      List<AlianzaBeneficiarioEntity> perfilesBeneficiariosEntity);
}

class AlianzaBeneficiarioLocalDataSourceImpl
    implements AlianzaBeneficiarioLocalDataSource {
  static createAlianzaBeneficiarioTable(Database db) async {
    await db.execute('''
      CREATE TABLE AlianzaBeneficiario (
        AlianzaId	TEXT NOT NULL,
        BeneficiarioId	TEXT NOT NULL,
        MunicipioId	TEXT NOT NULL,
        VeredaId	TEXT NOT NULL,
        AreaFinca	TEXT,
        AreaProyecto	TEXT,
        TipoTenenciaId	TEXT NOT NULL,
        Experiencia	TEXT,
        Asociado	TEXT,
        ConocePerfil	TEXT,
        FueBeneficiado	TEXT,
        CualBeneficio	TEXT,
        Activo	TEXT,
        MiembrosHogar	TEXT,
        MiembrosEcoActivos	TEXT,
        ResidenciaId	TEXT NOT NULL,
        AccesoExplotacionTierra	TEXT,
        GastosMensuales	TEXT,
        MesesAsociado	TEXT,
        NombreOrganizacion	TEXT,
        ActivoInmobiliario	TEXT,
        ActivoFinanciero	TEXT,
        ActivoProductivo	TEXT,
        ActivoCorriente	TEXT,
        Nota	TEXT,
        NombreFinca	TEXT,
        NivelEscolarId	TEXT NOT NULL,
        CotizanteBEPS	TEXT,
        EstadoCivilId	TEXT NOT NULL,
        CalificacionSISBEN	TEXT,
        IngresosMensuales	TEXT,
        TipoDiscapacidadId	TEXT NOT NULL,
        ConyugeTipoIdentificacionId	TEXT NOT NULL,
        ConyugeId	TEXT NOT NULL,
        ConyugeNombre1	TEXT,
        ConyugeNombre2	TEXT,
        ConyugeApellido1	TEXT,
        ConyugeApellido2	TEXT,
        ConyugeGeneroId	TEXT NOT NULL,
        ConyugeFechaExpedicionDocumento	TEXT,
        ConyugeGrupoEspecialId	TEXT NOT NULL,∫
        ConyugeFechaNacimiento	TEXT,
        ConyugeIngresosMensuales	TEXT,
        ActividadEconomicaId	TEXT NOT NULL,
        IngresosDiarios	TEXT,
        DiasTrabajo	TEXT,
        Longitud	TEXT,
        Latitud	TEXT,
        CedulaCatastral	TEXT,
        RecordStatus	TEXT,
        FOREIGN KEY(TipoDiscapacidadId) REFERENCES TipoDiscapacidad(TipoDiscapacidadId),
        FOREIGN KEY(VeredaId) REFERENCES Vereda(VeredaId),
        FOREIGN KEY(ConyugeTipoIdentificacionId) REFERENCES TipoIdentificacion(TipoIdentificacionId),
        FOREIGN KEY(EstadoCivilId) REFERENCES EstadoCivil(EstadoCivilId),
        FOREIGN KEY(ResidenciaId) REFERENCES Residencia(ResidenciaId),
        FOREIGN KEY(ConyugeGrupoEspecialId) REFERENCES GrupoEspecial(GrupoEspecialId),
        FOREIGN KEY(BeneficiarioId) REFERENCES Beneficiario(BeneficiarioId),
        FOREIGN KEY(MunicipioId) REFERENCES Municipio(MunicipioId),
        FOREIGN KEY(ConyugeGeneroId) REFERENCES Genero(GeneroId),
        FOREIGN KEY(ActividadEconomicaId) REFERENCES ActividadEconomica(ActividadEconomicaId),
        FOREIGN KEY(NivelEscolarId) REFERENCES NivelEscolar(NivelEscolarId),
        FOREIGN KEY(TipoTenenciaId) REFERENCES TipoTenencia(TipoTenenciaId),
        FOREIGN KEY(AlianzaId) REFERENCES Alianza(AlianzaId)
      )
    ''');
  }

  @override
  Future<List<AlianzaBeneficiarioModel>> getAlianzasBeneficiariosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('AlianzaBeneficiario');

    final alianzasBeneficiariosDB = List<AlianzaBeneficiarioModel>.from(
        res.map((m) => AlianzaBeneficiarioModel.fromJson(m))).toList();

    return alianzasBeneficiariosDB;
  }

  @override
  Future<AlianzaBeneficiarioModel?> getAlianzaBeneficiarioDB(
      String alianzaId, String beneficiarioId) async {
    final db = await DBConfig.database;

    final res = await db.query('AlianzaBeneficiario',
        where: 'AlianzaId = ? AND BeneficiarioId = ?',
        whereArgs: [alianzaId, beneficiarioId]);

    if (res.isEmpty) return null;
    final alianzaBeneficiarioMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final alianzaBeneficiarioModel =
        AlianzaBeneficiarioModel.fromJson(alianzaBeneficiarioMap);

    return alianzaBeneficiarioModel;
  }

  @override
  Future<int> saveAlianzasBeneficiarios(
      List<AlianzaBeneficiarioEntity> alianzaBeneficiarioEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('AlianzaBeneficiario');

    for (var alianzaBeneficiario in alianzaBeneficiarioEntity) {
      alianzaBeneficiario.recordStatus = 'R';
      batch.insert('AlianzaBeneficiario', alianzaBeneficiario.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> saveAlianzaBeneficiarioDB(
      AlianzaBeneficiarioEntity alianzaBeneficiarioEntity) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query('AlianzaBeneficiario',
        where: 'PerfilPreinversionId = ? AND BeneficiarioId = ?',
        whereArgs: [
          alianzaBeneficiarioEntity.alianzaId,
          alianzaBeneficiarioEntity.beneficiarioId
        ]);

    if (resQuery.isEmpty) {
      alianzaBeneficiarioEntity.recordStatus = 'N';
      batch.insert('AlianzaBeneficiario', alianzaBeneficiarioEntity.toJson());
    } else {
      alianzaBeneficiarioEntity.recordStatus = 'E';
      batch.update('AlianzaBeneficiario', alianzaBeneficiarioEntity.toJson(),
          where: 'PerfilPreinversionId = ? AND BeneficiarioId = ?',
          whereArgs: [
            alianzaBeneficiarioEntity.alianzaId,
            alianzaBeneficiarioEntity.beneficiarioId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<AlianzaBeneficiarioModel>>
      getAlianzasBeneficiariosProduccionDB() async {
    final db = await DBConfig.database;

    final res = await db.query('AlianzaBeneficiario',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    if (res.isEmpty) return [];

    final alianzasBeneficiariosModel = List<AlianzaBeneficiarioModel>.from(
        res.map((m) => AlianzaBeneficiarioModel.fromJson(m))).toList();

    return alianzasBeneficiariosModel;
  }

  @override
  Future<int> updateAlianzasBeneficiariosProduccionDB(
      List<AlianzaBeneficiarioEntity>
          alianzasBeneficiariosProduccionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var alianzaBeneficiarioProduccion
        in alianzasBeneficiariosProduccionEntity) {
      alianzaBeneficiarioProduccion.recordStatus = 'R';
      batch.update(
          'AlianzaBeneficiario', alianzaBeneficiarioProduccion.toJson(),
          where: 'PerfilPreinversionId = ? AND BeneficiarioId = ?',
          whereArgs: [
            alianzaBeneficiarioProduccion.alianzaId,
            alianzaBeneficiarioProduccion.beneficiarioId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }
}
