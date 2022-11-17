class PerfilBeneficiarioEntity {
  PerfilBeneficiarioEntity({
    required this.perfilId,
    required this.beneficiarioId,
    required this.municipioId,
    required this.veredaId,
    required this.areaFinca,
    required this.areaProyecto,
    required this.tipoTenenciaId,
    required this.experiencia,
    required this.asociado,
    required this.conocePerfil,
    required this.fueBeneficiado,
    required this.cualBeneficio,
    required this.activo,
    required this.recordStatus,
  });

  String perfilId;
  String beneficiarioId;
  String municipioId;
  String veredaId;
  String areaFinca;
  String areaProyecto;
  String tipoTenenciaId;
  String experiencia;
  String asociado;
  String conocePerfil;
  String fueBeneficiado;
  String cualBeneficio;
  String activo;
  String recordStatus;

  PerfilBeneficiarioEntity copyWith({
    String? perfilId,
    String? beneficiarioId,
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
    String? recordStatus,
  }) =>
      PerfilBeneficiarioEntity(
        perfilId: perfilId ?? this.perfilId,
        beneficiarioId: beneficiarioId ?? this.beneficiarioId,
        municipioId: municipioId ?? this.municipioId,
        veredaId: veredaId ?? this.veredaId,
        areaFinca: areaFinca ?? this.areaFinca,
        areaProyecto: areaProyecto ?? this.areaProyecto,
        tipoTenenciaId: tipoTenenciaId ?? this.tipoTenenciaId,
        experiencia: experiencia ?? this.experiencia,
        asociado: asociado ?? this.asociado,
        conocePerfil: conocePerfil ?? this.conocePerfil,
        fueBeneficiado: fueBeneficiado ?? this.fueBeneficiado,
        cualBeneficio: cualBeneficio ?? this.cualBeneficio,
        activo: activo ?? this.activo,
        recordStatus: recordStatus ?? this.recordStatus,
      );

  factory PerfilBeneficiarioEntity.fromJson(Map<String, dynamic> json) =>
      PerfilBeneficiarioEntity(
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
        recordStatus: json["RecordStatus"],
      );

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
        "RecordStatus": recordStatus,
      };
}
