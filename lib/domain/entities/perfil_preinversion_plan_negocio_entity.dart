class PerfilPreInversionPlanNegocioEntity {
  PerfilPreInversionPlanNegocioEntity({
    this.perfilPreInversionId,
    this.rubroId,
    this.year,
    this.valor,
    this.cantidad,
    this.unidadId,
    this.productoId,
    this.tipoCalidadId,
    this.recordStatus,
  });

  String? perfilPreInversionId;
  String? rubroId;
  String? year;
  String? valor;
  String? cantidad;
  String? unidadId;
  String? productoId;
  String? tipoCalidadId;
  String? recordStatus;

  PerfilPreInversionPlanNegocioEntity copyWith(
      {String? perfilPreInversionId,
      String? rubroId,
      String? year,
      String? valor,
      String? cantidad,
      String? unidadId,
      String? productoId,
      String? tipoCalidadId,
      String? recordStatus}) {
    return PerfilPreInversionPlanNegocioEntity(
      perfilPreInversionId: perfilPreInversionId ?? this.perfilPreInversionId,
      rubroId: rubroId ?? this.rubroId,
      year: year ?? this.year,
      valor: valor ?? this.valor,
      cantidad: cantidad ?? this.cantidad,
      unidadId: unidadId ?? this.unidadId,
      productoId: productoId ?? this.productoId,
      tipoCalidadId: tipoCalidadId ?? this.tipoCalidadId,
      recordStatus: recordStatus ?? this.recordStatus,
    );
  }

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
