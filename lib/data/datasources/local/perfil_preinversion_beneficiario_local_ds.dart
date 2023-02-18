import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/perfil_preinversion_beneficiario_entity.dart';
import '../../../domain/db/db_config.dart';
import '../../models/perfil_preinversion_beneficiario_model.dart';

abstract class PerfilPreInversionBeneficiarioLocalDataSource {
  Future<List<PerfilPreInversionBeneficiarioModel>>
      getPerfilPreInversionBeneficiariosDB(String perfilPreInversionId);
  Future<List<PerfilPreInversionBeneficiarioModel>>
      getPerfilesPreInversionesBeneficiariosProduccionDB();
  Future<PerfilPreInversionBeneficiarioModel?>
      getPerfilPreInversionBeneficiarioDB(
          String perfilPreInversionId, String beneficiarioId);
  Future<int> savePerfilPreInversionBeneficiarios(
      List<PerfilPreInversionBeneficiarioEntity>
          perfilPreInversionBeneficiarioEntity);
  Future<int> savePerfilPreInversionBeneficiarioDB(
      PerfilPreInversionBeneficiarioEntity
          perfilPreInversionBeneficiarioEntity);
  Future<int> updatePerfilesPreInversionesBeneficiariosProduccionDB(
      List<PerfilPreInversionBeneficiarioEntity> perfilesBeneficiariosEntity);
}

class PerfilPreInversionBeneficiarioLocalDataSourceImpl
    implements PerfilPreInversionBeneficiarioLocalDataSource {
  static createPerfilPreInversionBeneficiarioTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS PerfilPreInversionBeneficiario (
        PerfilPreInversionId	TEXT NOT NULL,
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
        BeneficioId	TEXT,
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
        ConyugeGrupoEspecialId	TEXT NOT NULL,
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
        FOREIGN KEY(PerfilPreInversionId) REFERENCES PerfilPreInversion(PerfilPreInversionId)
      )
    ''');
  }

  @override
  Future<List<PerfilPreInversionBeneficiarioModel>>
      getPerfilPreInversionBeneficiariosDB(String perfilPreInversionId) async {
    final db = await DBConfig.database;

    String sql = '''
      select
      PerfilPreInversionBeneficiario.PerfilPreInversionId,
      PerfilPreInversionBeneficiario.BeneficiarioId,
      PerfilPreInversionBeneficiario.MunicipioId,
      PerfilPreInversionBeneficiario.VeredaId,
      PerfilPreInversionBeneficiario.AreaFinca,
      PerfilPreInversionBeneficiario.AreaProyecto,
      PerfilPreInversionBeneficiario.TipoTenenciaId,
      PerfilPreInversionBeneficiario.Experiencia,
      PerfilPreInversionBeneficiario.Asociado,
      PerfilPreInversionBeneficiario.ConocePerfil,
      PerfilPreInversionBeneficiario.FueBeneficiado,
      PerfilPreInversionBeneficiario.CualBeneficio,
      PerfilPreInversionBeneficiario.BeneficioId,
      PerfilPreInversionBeneficiario.Activo,
      PerfilPreInversionBeneficiario.MiembrosHogar,
      PerfilPreInversionBeneficiario.MiembrosEcoActivos,
      PerfilPreInversionBeneficiario.ResidenciaId,
      PerfilPreInversionBeneficiario.AccesoExplotacionTierra,
      PerfilPreInversionBeneficiario.GastosMensuales,
      PerfilPreInversionBeneficiario.MesesAsociado,
      PerfilPreInversionBeneficiario.NombreOrganizacion,
      PerfilPreInversionBeneficiario.ActivoInmobiliario,
      PerfilPreInversionBeneficiario.ActivoFinanciero,
      PerfilPreInversionBeneficiario.ActivoProductivo,
      PerfilPreInversionBeneficiario.ActivoCorriente,
      PerfilPreInversionBeneficiario.Nota,
      PerfilPreInversionBeneficiario.NombreFinca,
      PerfilPreInversionBeneficiario.NivelEscolarId,
      PerfilPreInversionBeneficiario.CotizanteBEPS,
      PerfilPreInversionBeneficiario.EstadoCivilId,
      PerfilPreInversionBeneficiario.CalificacionSISBEN,
      PerfilPreInversionBeneficiario.IngresosMensuales,
      PerfilPreInversionBeneficiario.TipoDiscapacidadId,
      PerfilPreInversionBeneficiario.ConyugeTipoIdentificacionId,
      PerfilPreInversionBeneficiario.ConyugeId,
      PerfilPreInversionBeneficiario.ConyugeNombre1,
      PerfilPreInversionBeneficiario.ConyugeNombre2,
      PerfilPreInversionBeneficiario.ConyugeApellido1,
      PerfilPreInversionBeneficiario.ConyugeApellido2,
      PerfilPreInversionBeneficiario.ConyugeGeneroId,
      PerfilPreInversionBeneficiario.ConyugeFechaExpedicionDocumento,
      PerfilPreInversionBeneficiario.ConyugeGrupoEspecialId,
      PerfilPreInversionBeneficiario.ConyugeFechaNacimiento,
      PerfilPreInversionBeneficiario.ConyugeIngresosMensuales,
      PerfilPreInversionBeneficiario.ActividadEconomicaId,
      PerfilPreInversionBeneficiario.IngresosDiarios,
      PerfilPreInversionBeneficiario.DiasTrabajo,
      PerfilPreInversionBeneficiario.Longitud,
      PerfilPreInversionBeneficiario.Latitud,
      PerfilPreInversionBeneficiario.CedulaCatastral,
      PerfilPreInversionBeneficiario.BeneficiarioId as Documento,
      TipoIdentificacion.Nombre as TipoDocumento,
      Beneficiario.Nombre1 || " " || Beneficiario.Nombre2 || " " || Beneficiario.Apellido1 || " " || Beneficiario.Apellido2 as Nombre,
      cast(strftime('%Y.%m%d', 'now') - strftime('%Y.%m%d', Beneficiario.FechaNacimiento ) as int) as Edad,
      Genero.Nombre as Genero,
      GrupoEspecial.Nombre as GrupoEspecial,
      Departamento.Nombre || " / " || Municipio.Nombre || " / "  || Vereda.Nombre as Ubicacion
      from PerfilPreInversionBeneficiario
      inner join Beneficiario  on PerfilPreInversionBeneficiario.BeneficiarioId = Beneficiario.BeneficiarioId
      left join TipoIdentificacion on TipoIdentificacion.TipoIdentificacionId=Beneficiario.TipoIdentificacionId
      left join Genero on Genero.GeneroId=Beneficiario.GeneroId
      left join GrupoEspecial on GrupoEspecial.GrupoEspecialId=Beneficiario.GrupoEspecialId
      left join Municipio on Municipio.MunicipioId=PerfilPreInversionBeneficiario.MunicipioId
      left join Departamento on Departamento.DepartamentoId=Municipio.DepartamentoId
      left join Vereda on Vereda.VeredaId=PerfilPreInversionBeneficiario.VeredaId
      where PerfilPreInversionId = $perfilPreInversionId
    ''';

    final res = await db.rawQuery(sql);

    final perfilPreInversionBeneficiariosDB =
        List<PerfilPreInversionBeneficiarioModel>.from(
                res.map((m) => PerfilPreInversionBeneficiarioModel.fromJson(m)))
            .toList();

    return perfilPreInversionBeneficiariosDB;
  }

  @override
  Future<PerfilPreInversionBeneficiarioModel?>
      getPerfilPreInversionBeneficiarioDB(
          String perfilPreInversionId, String beneficiarioId) async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionBeneficiario',
        where: 'PerfilPreInversionId = ? AND BeneficiarioId = ?',
        whereArgs: [perfilPreInversionId, beneficiarioId]);

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
      perfilPreInversionBeneficiario.recordStatus = 'R';
      batch.insert('PerfilPreInversionBeneficiario',
          perfilPreInversionBeneficiario.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> savePerfilPreInversionBeneficiarioDB(
      PerfilPreInversionBeneficiarioEntity
          perfilPreInversionBeneficiarioEntity) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query('PerfilPreInversionBeneficiario',
        where: 'PerfilPreinversionId = ? AND BeneficiarioId = ?',
        whereArgs: [
          perfilPreInversionBeneficiarioEntity.perfilPreInversionId,
          perfilPreInversionBeneficiarioEntity.beneficiarioId
        ]);

    if (resQuery.isEmpty) {
      perfilPreInversionBeneficiarioEntity.recordStatus = 'N';
      batch.insert('PerfilPreInversionBeneficiario',
          perfilPreInversionBeneficiarioEntity.toJson());
    } else {
      perfilPreInversionBeneficiarioEntity.recordStatus = 'E';
      batch.update('PerfilPreInversionBeneficiario',
          perfilPreInversionBeneficiarioEntity.toJson(),
          where: 'PerfilPreinversionId = ? AND BeneficiarioId = ?',
          whereArgs: [
            perfilPreInversionBeneficiarioEntity.perfilPreInversionId,
            perfilPreInversionBeneficiarioEntity.beneficiarioId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<PerfilPreInversionBeneficiarioModel>>
      getPerfilesPreInversionesBeneficiariosProduccionDB() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionBeneficiario',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    if (res.isEmpty) return [];

    final perfilesPreInversionesBeneficiariosModel =
        List<PerfilPreInversionBeneficiarioModel>.from(
                res.map((m) => PerfilPreInversionBeneficiarioModel.fromJson(m)))
            .toList();

    return perfilesPreInversionesBeneficiariosModel;
  }

  @override
  Future<int> updatePerfilesPreInversionesBeneficiariosProduccionDB(
      List<PerfilPreInversionBeneficiarioEntity>
          perfilesPreInversionesBeneficiariosProduccionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var perfilPreInversionBeneficiarioProduccion
        in perfilesPreInversionesBeneficiariosProduccionEntity) {
      perfilPreInversionBeneficiarioProduccion.recordStatus = 'R';
      batch.update('PerfilPreInversionBeneficiario',
          perfilPreInversionBeneficiarioProduccion.toJson(),
          where: 'PerfilPreinversionId = ? AND BeneficiarioId = ?',
          whereArgs: [
            perfilPreInversionBeneficiarioProduccion.perfilPreInversionId,
            perfilPreInversionBeneficiarioProduccion.beneficiarioId
          ]);
    }

    await batch.commit();
    final query = await db.query('PerfilPreInversionBeneficiario',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    return query.length;
  }
}
