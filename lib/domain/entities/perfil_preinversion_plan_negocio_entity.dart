class PerfilPreInversionPlanNegocioEntity {
  PerfilPreInversionPlanNegocioEntity({
    required this.perfilPreInversionId,
    required this.rubroId,
    required this.year,
    required this.valor,
    required this.cantidad,
    required this.unidadId,
    required this.productoId,
    required this.tipoCalidadId,
    required this.recordStatus,
  });

  String perfilPreInversionId;
  String rubroId;
  String year;
  String valor;
  String cantidad;
  String unidadId;
  String productoId;
  String tipoCalidadId;
  String recordStatus;

  factory PerfilPreInversionPlanNegocioEntity.fromJson(
          Map<String, dynamic> json) =>
      PerfilPreInversionPlanNegocioEntity(
        perfilPreInversionId: json["PerfilPreInversionId"],
        rubroId: json["RubroId"],
        year: json["Year"],
        valor: json["Valor"],
        cantidad: json["Cantidad"],
        unidadId: json["UnidadId"],
        productoId: json["ProductoId"],
        tipoCalidadId: json["TipoCalidadId"],
        recordStatus: json["RecordStatus"],
      );

  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "RubroId": rubroId,
        "Year": year,
        "Valor": valor,
        "Cantidad": cantidad,
        "UnidadId": unidadId,
        "ProductoId": productoId,
        "TipoCalidadId": tipoCalidadId,
        "RecordStatus": recordStatus,
      };
}
