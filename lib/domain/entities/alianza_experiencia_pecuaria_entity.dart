class AlianzaExperienciaPecuariaEntity {
  AlianzaExperienciaPecuariaEntity({
    this.tipoActividadProductivaId,
    this.beneficiarioId,
    this.frecuenciaId,
    this.cantidadAnimales,
    this.cantidadCria,
    this.cantidadLevante,
    this.cantidadCeba,
    this.cantidadLeche,
    this.valorJornal,
    this.costosInsumos,
    this.ingresos,
    this.recordStatus,
  });

  String? tipoActividadProductivaId;
  String? beneficiarioId;
  String? frecuenciaId;
  String? cantidadAnimales;
  String? cantidadCria;
  String? cantidadLevante;
  String? cantidadCeba;
  String? cantidadLeche;
  String? valorJornal;
  String? costosInsumos;
  String? ingresos;
  String? recordStatus;

  AlianzaExperienciaPecuariaEntity copyWith({
    String? tipoActividadProductivaId,
    String? beneficiarioId,
    String? frecuenciaId,
    String? cantidadAnimales,
    String? cantidadCria,
    String? cantidadLevante,
    String? cantidadCeba,
    String? cantidadLeche,
    String? valorJornal,
    String? costosInsumos,
    String? ingresos,
    String? recordStatus,
  }) =>
      AlianzaExperienciaPecuariaEntity(
        tipoActividadProductivaId:
            tipoActividadProductivaId ?? this.tipoActividadProductivaId,
        beneficiarioId: beneficiarioId ?? this.beneficiarioId,
        frecuenciaId: frecuenciaId ?? this.frecuenciaId,
        cantidadAnimales: cantidadAnimales ?? this.cantidadAnimales,
        cantidadCria: cantidadCria ?? this.cantidadCria,
        cantidadLevante: cantidadLevante ?? this.cantidadLevante,
        cantidadCeba: cantidadCeba ?? this.cantidadCeba,
        cantidadLeche: cantidadLeche ?? this.cantidadLeche,
        valorJornal: valorJornal ?? this.valorJornal,
        costosInsumos: costosInsumos ?? this.costosInsumos,
        ingresos: ingresos ?? this.ingresos,
        recordStatus: recordStatus ?? this.recordStatus,
      );

  Map<String, dynamic> toJson() => {
        "TipoActividadProductivaId": tipoActividadProductivaId,
        "BeneficiarioId": beneficiarioId,
        "FrecuenciaId": frecuenciaId,
        "CantidadAnimales": cantidadAnimales,
        "CantidadCria": cantidadCria,
        "CantidadLevante": cantidadLevante,
        "CantidadCeba": cantidadCeba,
        "CantidadLeche": cantidadLeche,
        "ValorJornal": valorJornal,
        "CostosInsumos": costosInsumos,
        "Ingresos": ingresos,
        "RecordStatus": recordStatus,
      };
}
