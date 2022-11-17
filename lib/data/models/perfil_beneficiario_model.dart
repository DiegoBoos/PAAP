import 'package:paap/domain/entities/perfil_beneficiario_entity.dart';

class PerfilBeneficiarioModel extends PerfilBeneficiarioEntity {
  PerfilBeneficiarioModel({
    required String perfilId,
    required String beneficiarioId,
    required String municipioId,
    required String veredaId,
    String? areaFinca,
    String? areaProyecto,
    required String tipoTenenciaId,
    String? experiencia,
    String? asociado,
    String? conocePerfil,
    String? fueBeneficiado,
    String? cualBeneficio,
    String? activo,
  }) : super(
            perfilId: perfilId,
            beneficiarioId: beneficiarioId,
            municipioId: municipioId,
            veredaId: veredaId,
            areaFinca: areaFinca ?? '',
            areaProyecto: areaProyecto ?? '',
            tipoTenenciaId: tipoTenenciaId,
            experiencia: experiencia ?? '',
            asociado: asociado ?? '',
            conocePerfil: conocePerfil ?? '',
            fueBeneficiado: fueBeneficiado ?? '',
            cualBeneficio: cualBeneficio ?? '',
            activo: activo ?? '');

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
      );

  @override
  Map<String, dynamic> toJson() => {
        "PerfilId": perfilId,
        "BeneficiarioId": beneficiarioId,
        "MunicipioId": municipioId,
        "VeredaId": veredaId,
        "AreaFinca": areaFinca,
        "AreaProyecto": areaProyecto,
        "TipoTenenciaId": tipoTenenciaId,
        "Experiencia": experiencia,
        "Asociado": asociado,
        "ConocePerfil": conocePerfil,
        "FueBeneficiado": fueBeneficiado,
        "CualBeneficio": cualBeneficio,
        "Activo": activo,
      };
}
