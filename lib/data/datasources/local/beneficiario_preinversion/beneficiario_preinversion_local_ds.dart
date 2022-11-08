import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/beneficiario_preinversion_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/beneficiario_preinversion_model.dart';

abstract class BeneficiarioPreinversionLocalDataSource {
  Future<List<BeneficiarioPreinversionModel>>
      getBeneficiariosPreinversionesDB();
  Future<BeneficiarioPreinversionModel?> getBeneficiarioPreinversionDB(
      String id);
  Future<int> saveBeneficiariosPreinversiones(
      List<BeneficiarioPreinversionEntity> beneficiariopreinversionEntity);
}

class BeneficiarioPreinversionLocalDataSourceImpl
    implements BeneficiarioPreinversionLocalDataSource {
  static createBeneficiarioPreinversionTable(Database db) async {
    await db.execute('''
      CREATE TABLE PerfilPreinversionBeneficiario (
        PerfilPreInversionId	INTEGER NOT NULL,
        BeneficiarioId	INTEGER NOT NULL,
        MunicipioId	INTEGER NOT NULL,
        VeredaId	INTEGER NOT NULL,
        AreaFinca	INTEGER,
        AreaProyecto	INTEGER,
        TipoTenenciaId	INTEGER NOT NULL,
        Experiencia	INTEGER,
        Asociado	INTEGER,
        ConocePerfil	INTEGER,
        FueBeneficiado	INTEGER,
        CualBeneficio	TEXT,
        Activo	INTEGER,
        MiembrosHogar	INTEGER,
        MiembrosEcoActivos	INTEGER,
        ResidenciaId	INTEGER NOT NULL,
        AccesoExplotacionTierra	INTEGER,
        GastosMensuales	INTEGER,
        MesesAsociado	INTEGER,
        NombreOrganizacion	TEXT,
        ActivoInmobiliario	INTEGER,
        ActivoFinanciero	INTEGER,
        ActivoProductivo	INTEGER,
        ActivoCorriente	INTEGER,
        Nota	TEXT,
        NombreFinca	TEXT,
        NivelEscolarId	INTEGER NOT NULL,
        CotizanteBEPS	INTEGER,
        EstadoCivilId	INTEGER NOT NULL,
        CalificacionSISBEN	INTEGER,
        IngresosMensuales	INTEGER,
        TipoDiscapacidadId	INTEGER NOT NULL,
        ConyugeTipoIdentificacionId	INTEGER NOT NULL,
        ConyugeId	INTEGER NOT NULL,
        ConyugeNombre1	TEXT,
        ConyugeNombre2	TEXT,
        ConyugeApellido1	TEXT,
        ConyugeApellido2	TEXT,
        ConyugeGeneroId	INTEGER NOT NULL,
        ConyugeFechaExpedicionDocumento	TEXT,
        ConyugeGrupoEspecialId	INTEGER NOT NULL,
        ConyugeFechaNacimiento	TEXT,
        ConyugeIngresosMensuales	INTEGER,
        ActividadEconomicaId	INTEGER NOT NULL,
        IngresosDiarios	INTEGER,
        DiasTrabajo	INTEGER,
        Longitud	INTEGER,
        Latitud	INTEGER,
        CedulaCatastral	TEXT,
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
        FOREIGN KEY(PerfilPreInversionId) REFERENCES PerfilPreinversion(PerfilPreInversionId)
      )
    ''');
  }

  @override
  Future<List<BeneficiarioPreinversionModel>>
      getBeneficiariosPreinversionesDB() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreinversionBeneficiario');

    final beneficiariospreinversionesDB =
        List<BeneficiarioPreinversionModel>.from(
            res.map((m) => BeneficiarioPreinversionModel.fromJson(m))).toList();

    return beneficiariospreinversionesDB;
  }

  @override
  Future<BeneficiarioPreinversionModel?> getBeneficiarioPreinversionDB(
      String id) async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreinversionBeneficiario',
        where: 'PerfilPreInversionId = ?', whereArgs: [id]);

    if (res.isEmpty) return null;
    final beneficiariopreinversionMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final beneficiariopreinversionModel =
        BeneficiarioPreinversionModel.fromJson(beneficiariopreinversionMap);

    return beneficiariopreinversionModel;
  }

  @override
  Future<int> saveBeneficiariosPreinversiones(
      List<BeneficiarioPreinversionEntity>
          beneficiariopreinversionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('PerfilPreinversionBeneficiario');

    for (var beneficiariopreinversion in beneficiariopreinversionEntity) {
      batch.insert(
          'PerfilPreinversionBeneficiario', beneficiariopreinversion.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
