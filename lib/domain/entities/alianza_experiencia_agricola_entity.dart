class AlianzaExperienciaAgricolaEntity {
  AlianzaExperienciaAgricolaEntity({
    this.tipoActividadProductivaId,
    this.beneficiarioId,
    this.frecuenciaId,
    this.areaCultivo,
    this.cantidadProducida,
    this.cantidadVendida,
    this.cantidadAutoconsumo,
    this.costoImplementacion,
    this.valorJornal,
    this.totalIngresoNeto,
    this.areaPasto,
    this.areaSinUso,
    this.areaReservaConservacion,
    this.areaImplementacion,
    this.totalAreaPredio,
    this.recordStatus,
  });

  String? tipoActividadProductivaId;
  String? beneficiarioId;
  String? frecuenciaId;
  String? areaCultivo;
  String? cantidadProducida;
  String? cantidadVendida;
  String? cantidadAutoconsumo;
  String? costoImplementacion;
  String? valorJornal;
  String? totalIngresoNeto;
  String? areaPasto;
  String? areaSinUso;
  String? areaReservaConservacion;
  String? areaImplementacion;
  String? totalAreaPredio;
  String? recordStatus;

  AlianzaExperienciaAgricolaEntity copyWith({
    String? tipoActividadProductivaId,
    String? beneficiarioId,
    String? frecuenciaId,
    String? areaCultivo,
    String? cantidadProducida,
    String? cantidadVendida,
    String? cantidadAutoconsumo,
    String? costoImplementacion,
    String? valorJornal,
    String? totalIngresoNeto,
    String? areaPasto,
    String? areaSinUso,
    String? areaReservaConservacion,
    String? areaImplementacion,
    String? totalAreaPredio,
    String? recordStatus,
  }) =>
      AlianzaExperienciaAgricolaEntity(
        tipoActividadProductivaId:
            tipoActividadProductivaId ?? this.tipoActividadProductivaId,
        beneficiarioId: beneficiarioId ?? this.beneficiarioId,
        frecuenciaId: frecuenciaId ?? this.frecuenciaId,
        areaCultivo: areaCultivo ?? this.areaCultivo,
        cantidadProducida: cantidadProducida ?? this.cantidadProducida,
        cantidadVendida: cantidadVendida ?? this.cantidadVendida,
        cantidadAutoconsumo: cantidadAutoconsumo ?? this.cantidadAutoconsumo,
        costoImplementacion: costoImplementacion ?? this.costoImplementacion,
        valorJornal: valorJornal ?? this.valorJornal,
        totalIngresoNeto: totalIngresoNeto ?? this.totalIngresoNeto,
        areaPasto: areaPasto ?? this.areaPasto,
        areaSinUso: areaSinUso ?? this.areaSinUso,
        areaReservaConservacion:
            areaReservaConservacion ?? this.areaReservaConservacion,
        areaImplementacion: areaImplementacion ?? this.areaImplementacion,
        totalAreaPredio: totalAreaPredio ?? this.totalAreaPredio,
        recordStatus: recordStatus ?? this.recordStatus,
      );

  Map<String, dynamic> toJson() => {
        "TipoActividadProductivaId": tipoActividadProductivaId,
        "BeneficiarioId": beneficiarioId,
        "FrecuenciaId": frecuenciaId,
        "AreaCultivo": areaCultivo,
        "CantidadProducida": cantidadProducida,
        "CantidadVendida": cantidadVendida,
        "CantidadAutoconsumo": cantidadAutoconsumo,
        "CostoImplementacion": costoImplementacion,
        "ValorJornal": valorJornal,
        "TotalIngresoNeto": totalIngresoNeto,
        "AreaPasto": areaPasto,
        "AreaSinUso": areaSinUso,
        "AreaReservaConservacion": areaReservaConservacion,
        "AreaImplementacion": areaImplementacion,
        "TotalAreaPredio": totalAreaPredio,
        "RecordStatus": recordStatus,
      };
}
