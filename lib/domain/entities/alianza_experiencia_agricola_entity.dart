class AlianzaExperienciaAgricolaEntity {
  AlianzaExperienciaAgricolaEntity({
    required this.tipoActividadProductivaId,
    required this.beneficiarioId,
    required this.frecuenciaId,
    required this.areaCultivo,
    required this.cantidadProducida,
    required this.cantidadVendida,
    required this.cantidadAutoconsumo,
    required this.costoImplementacion,
    required this.valorJornal,
    required this.totalIngresoNeto,
    required this.areaPasto,
    required this.areaSinUso,
    required this.areaReservaConservacion,
    required this.areaImplementacion,
    required this.totalAreaPredio,
    required this.recordStatus,
  });

  String tipoActividadProductivaId;
  String beneficiarioId;
  String frecuenciaId;
  String areaCultivo;
  String cantidadProducida;
  String cantidadVendida;
  String cantidadAutoconsumo;
  String costoImplementacion;
  String valorJornal;
  String totalIngresoNeto;
  String areaPasto;
  String areaSinUso;
  String areaReservaConservacion;
  String areaImplementacion;
  String totalAreaPredio;
  String recordStatus;

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

  factory AlianzaExperienciaAgricolaEntity.fromJson(
          Map<String, dynamic> json) =>
      AlianzaExperienciaAgricolaEntity(
        tipoActividadProductivaId: json["TipoActividadProductivaId"],
        beneficiarioId: json["BeneficiarioId"],
        frecuenciaId: json["FrecuenciaId"],
        areaCultivo: json["AreaCultivo"],
        cantidadProducida: json["CantidadProducida"],
        cantidadVendida: json["CantidadVendida"],
        cantidadAutoconsumo: json["CantidadAutoconsumo"],
        costoImplementacion: json["CostoImplementacion"],
        valorJornal: json["ValorJornal"],
        totalIngresoNeto: json["TotalIngresoNeto"],
        areaPasto: json["AreaPasto"],
        areaSinUso: json["AreaSinUso"],
        areaReservaConservacion: json["AreaReservaConservacion"],
        areaImplementacion: json["AreaImplementacion"],
        totalAreaPredio: json["TotalAreaPredio"],
        recordStatus: json["RecordStatus"],
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
