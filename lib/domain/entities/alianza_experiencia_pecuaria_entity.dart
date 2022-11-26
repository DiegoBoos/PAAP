class AlianzaExperienciaPecuariaEntity {
  AlianzaExperienciaPecuariaEntity({
    required this.tipoActividadProductivaId,
    required this.beneficiarioId,
    required this.frecuenciaId,
    required this.cantidadAnimales,
    required this.cantidadCria,
    required this.cantidadLevante,
    required this.cantidadCeba,
    required this.cantidadLeche,
    required this.valorJornal,
    required this.costosInsumos,
    required this.ingresos,
    required this.recordStatus,
  });

  String tipoActividadProductivaId;
  String beneficiarioId;
  String frecuenciaId;
  String cantidadAnimales;
  String cantidadCria;
  String cantidadLevante;
  String cantidadCeba;
  String cantidadLeche;
  String valorJornal;
  String costosInsumos;
  String ingresos;
  String recordStatus;

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

  factory AlianzaExperienciaPecuariaEntity.fromJson(
          Map<String, dynamic> json) =>
      AlianzaExperienciaPecuariaEntity(
        tipoActividadProductivaId: json["TipoActividadProductivaId"],
        beneficiarioId: json["BeneficiarioId"],
        frecuenciaId: json["FrecuenciaId"],
        cantidadAnimales: json["CantidadAnimales"],
        cantidadCria: json["CantidadCria"],
        cantidadLevante: json["CantidadLevante"],
        cantidadCeba: json["CantidadCeba"],
        cantidadLeche: json["CantidadLeche"],
        valorJornal: json["ValorJornal"],
        costosInsumos: json["CostosInsumos"],
        ingresos: json["Ingresos"],
        recordStatus: json["RecordStatus"],
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
