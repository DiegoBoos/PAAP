import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/perfil_preinversion_beneficiario_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/perfil_preinversion_beneficiario_model.dart';

abstract class PerfilPreInversionBeneficiarioLocalDataSource {
  Future<List<PerfilPreInversionBeneficiarioModel>>
      getPerfilPreInversionBeneficiariosDB();
  Future<PerfilPreInversionBeneficiarioModel?>
      getPerfilPreInversionBeneficiarioDB(String id);
  Future<int> savePerfilPreInversionBeneficiarios(
      List<PerfilPreInversionBeneficiarioEntity>
          perfilPreInversionBeneficiarioEntity);
}

class PerfilPreInversionBeneficiarioLocalDataSourceImpl
    implements PerfilPreInversionBeneficiarioLocalDataSource {
  static createPerfilPreInversionBeneficiarioTable(Database db) async {
    await db.execute('''
      CREATE TABLE PerfilPreInversionBeneficiario (
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
        FOREIGN KEY(PerfilPreInversionId) REFERENCES PerfilPreInversion(PerfilPreInversionId)
      )
    ''');
  }

  @override
  Future<List<PerfilPreInversionBeneficiarioModel>>
      getPerfilPreInversionBeneficiariosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionBeneficiario');

    final perfilPreInversionBeneficiariosDB =
        List<PerfilPreInversionBeneficiarioModel>.from(
                res.map((m) => PerfilPreInversionBeneficiarioModel.fromJson(m)))
            .toList();

    return perfilPreInversionBeneficiariosDB;
  }

  @override
  Future<PerfilPreInversionBeneficiarioModel?>
      getPerfilPreInversionBeneficiarioDB(String id) async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionBeneficiario',
        where: 'PerfilPreInversionId = ?', whereArgs: [id]);

    if (res.isEmpty) return null;
    final perfilPreInversionBeneficiarioMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final perfilPreInversionBeneficiarioModel =
        PerfilPreInversionBeneficiarioModel.fromJson(
            perfilPreInversionBeneficiarioMap);

    return perfilPreInversionBeneficiarioModel;
  }

  @override
  Future<int> savePerfilPreInversionBeneficiarios(
      List<PerfilPreInversionBeneficiarioEntity>
          perfilPreInversionBeneficiarioEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('PerfilPreInversionBeneficiario');

    for (var perfilPreInversionBeneficiario
        in perfilPreInversionBeneficiarioEntity) {
      batch.insert('PerfilPreInversionBeneficiario',
          perfilPreInversionBeneficiario.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
