class PerfilBeneficiarioEntity {
  PerfilBeneficiarioEntity({
    required this.perfilId,
    required this.beneficiarioId,
    this.municipioId,
    this.veredaId,
    this.areaFinca,
    this.areaProyecto,
    this.tipoTenenciaId,
    this.experiencia,
    this.asociado,
    this.conocePerfil,
    this.fueBeneficiado,
    this.cualBeneficio,
    this.activo,
    this.nombre,
    this.edad,
    this.recordStatus,
  });

  String perfilId;
  String beneficiarioId;
  String? municipioId;
  String? veredaId;
  String? areaFinca;
  String? areaProyecto;
  String? tipoTenenciaId;
  String? experiencia;
  String? asociado;
  String? conocePerfil;
  String? fueBeneficiado;
  String? cualBeneficio;
  String? beneficioId;
  String? activo;
  String? nombre;
  String? edad;
  String? recordStatus;

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
