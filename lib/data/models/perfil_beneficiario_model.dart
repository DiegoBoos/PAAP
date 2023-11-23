import 'package:paap/domain/entities/perfil_beneficiario_entity.dart';

class PerfilBeneficiarioModel extends PerfilBeneficiarioEntity {
  PerfilBeneficiarioModel({
    required String perfilId,
    required String beneficiarioId,
    String? municipioId,
    String? veredaId,
    String? areaFinca,
    String? areaProyecto,
    String? tipoTenenciaId,
    String? experiencia,
    String? asociado,
    String? conocePerfil,
    String? fueBeneficiado,
    String? cualBeneficio,
    String? activo,
    String? nombre,
    String? edad,
    String? recordStatus,
  }) : super(
          perfilId: perfilId,
          beneficiarioId: beneficiarioId,
          municipioId: municipioId,
          veredaId: veredaId,
          areaFinca: areaFinca,
          areaProyecto: areaProyecto,
          tipoTenenciaId: tipoTenenciaId,
          experiencia: experiencia,
          asociado: asociado,
          conocePerfil: conocePerfil,
          fueBeneficiado: fueBeneficiado,
          cualBeneficio: cualBeneficio,
          activo: activo,
          nombre: nombre,
          edad: edad,
          recordStatus: recordStatus,
        );

  factory PerfilBeneficiarioModel.fromJson(Map<String, dynamic> json) =>
      PerfilBeneficiarioModel(
        perfilId: json["PerfilId"],
        beneficiarioId: json["BeneficiarioId"],
        municipioId: json["MunicipioId"],
        veredaId: json["VeredaId"],
        areaFinca: json["AreaFinca"],
        areaProyecto: json["AreaProyecto"],
        tipoTenenciaId: json["TipoTenenciaId"],
        experiencia: json["Experiencia"],
        asociado: json["Asociado"],
        conocePerfil: json["ConocePerfil"],
        fueBeneficiado: json["FueBeneficiado"],
        cualBeneficio: json["CualBeneficio"],
        activo: json["Activo"],
        nombre: json["Nombre"],
        edad: json["Edad"].toString(),
        recordStatus: json["RecordStatus"],
      );
}
