import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/alianza_beneficiario_entity.dart';
import '../../db/db_config.dart';
import '../../models/alianza_beneficiario_model.dart';

abstract class AlianzaBeneficiarioLocalDataSource {
  Future<List<AlianzaBeneficiarioModel>> getAlianzasBeneficiariosDB(
      String alianzaId);
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
      CREATE TABLE IF NOT EXISTS AlianzaBeneficiario (
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
        FOREIGN KEY(AlianzaId) REFERENCES Alianza(AlianzaId)
      )
    ''');
  }

  @override
  Future<List<AlianzaBeneficiarioModel>> getAlianzasBeneficiariosDB(
      String alianzaId) async {
    final db = await DBConfig.database;

    String sql = '''
      select
      AlianzaBeneficiario.AlianzaId,
      AlianzaBeneficiario.BeneficiarioId,
      AlianzaBeneficiario.MunicipioId,
      AlianzaBeneficiario.VeredaId,
      AlianzaBeneficiario.AreaFinca,
      AlianzaBeneficiario.AreaProyecto,
      AlianzaBeneficiario.TipoTenenciaId,
      AlianzaBeneficiario.Experiencia,
      AlianzaBeneficiario.Asociado,
      AlianzaBeneficiario.ConocePerfil,
      AlianzaBeneficiario.FueBeneficiado,
      AlianzaBeneficiario.CualBeneficio,
      AlianzaBeneficiario.BeneficioId,
      AlianzaBeneficiario.Activo,
      AlianzaBeneficiario.MiembrosHogar,
      AlianzaBeneficiario.MiembrosEcoActivos,
      AlianzaBeneficiario.ResidenciaId,
      AlianzaBeneficiario.AccesoExplotacionTierra,
      AlianzaBeneficiario.GastosMensuales,
      AlianzaBeneficiario.MesesAsociado,
      AlianzaBeneficiario.NombreOrganizacion,
      AlianzaBeneficiario.ActivoInmobiliario,
      AlianzaBeneficiario.ActivoFinanciero,
      AlianzaBeneficiario.ActivoProductivo,
      AlianzaBeneficiario.ActivoCorriente,
      AlianzaBeneficiario.Nota,
      AlianzaBeneficiario.NombreFinca,
      AlianzaBeneficiario.NivelEscolarId,
      AlianzaBeneficiario.CotizanteBEPS,
      AlianzaBeneficiario.EstadoCivilId,
      AlianzaBeneficiario.CalificacionSISBEN,
      AlianzaBeneficiario.IngresosMensuales,
      AlianzaBeneficiario.TipoDiscapacidadId,
      AlianzaBeneficiario.ConyugeTipoIdentificacionId,
      AlianzaBeneficiario.ConyugeId,
      AlianzaBeneficiario.ConyugeNombre1,
      AlianzaBeneficiario.ConyugeNombre2,
      AlianzaBeneficiario.ConyugeApellido1,
      AlianzaBeneficiario.ConyugeApellido2,
      AlianzaBeneficiario.ConyugeGeneroId,
      AlianzaBeneficiario.ConyugeFechaExpedicionDocumento,
      AlianzaBeneficiario.ConyugeGrupoEspecialId,
      AlianzaBeneficiario.ConyugeFechaNacimiento,
      AlianzaBeneficiario.ConyugeIngresosMensuales,
      AlianzaBeneficiario.ActividadEconomicaId,
      AlianzaBeneficiario.IngresosDiarios,
      AlianzaBeneficiario.DiasTrabajo,
      AlianzaBeneficiario.Longitud,
      AlianzaBeneficiario.Latitud,
      AlianzaBeneficiario.CedulaCatastral,
      AlianzaBeneficiario.BeneficiarioId as Documento,
      TipoIdentificacion.Nombre as TipoDocumento,
      Beneficiario.Nombre1 || " " || Beneficiario.Nombre2 || " " || Beneficiario.Apellido1 || " " || Beneficiario.Apellido2 as Nombre,
      cast(strftime('%Y.%m%d', 'now') - strftime('%Y.%m%d', Beneficiario.FechaNacimiento ) as int) as Edad,
      Genero.Nombre as Genero,
      GrupoEspecial.Nombre as GrupoEspecial,
      Departamento.Nombre || " / " || Municipio.Nombre || " / "  || Vereda.Nombre as Ubicacion
      from AlianzaBeneficiario
      inner join Beneficiario  on AlianzaBeneficiario.BeneficiarioId = Beneficiario.BeneficiarioId
      left join TipoIdentificacion on TipoIdentificacion.TipoIdentificacionId=Beneficiario.TipoIdentificacionId
      left join Genero on Genero.GeneroId=Beneficiario.GeneroId
      left join GrupoEspecial on GrupoEspecial.GrupoEspecialId=Beneficiario.GrupoEspecialId
      left join Municipio on Municipio.MunicipioId=AlianzaBeneficiario.MunicipioId
      left join Departamento on Departamento.DepartamentoId=Municipio.DepartamentoId
      left join Vereda on Vereda.VeredaId=AlianzaBeneficiario.VeredaId
      where AlianzaId = $alianzaId
    ''';

    final res = await db.rawQuery(sql);

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
        where: 'AlianzaId = ? AND BeneficiarioId = ?',
        whereArgs: [
          alianzaBeneficiarioEntity.alianzaId,
          alianzaBeneficiarioEntity.beneficiarioId
        ]);

    if (resQuery.isEmpty) {
      alianzaBeneficiarioEntity.recordStatus = 'N';
      batch.insert('AlianzaBeneficiario', alianzaBeneficiarioEntity.toJson());
    } else {
      if (alianzaBeneficiarioEntity.recordStatus != 'N') {
        alianzaBeneficiarioEntity.recordStatus = 'E';
      }
      batch.update('AlianzaBeneficiario', alianzaBeneficiarioEntity.toJson(),
          where: 'AlianzaId = ? AND BeneficiarioId = ?',
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
          where: 'AlianzaId = ? AND BeneficiarioId = ?',
          whereArgs: [
            alianzaBeneficiarioProduccion.alianzaId,
            alianzaBeneficiarioProduccion.beneficiarioId
          ]);
    }

    await batch.commit();

    final query = await db.query('AlianzaBeneficiario',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    return query.length;
  }
}
