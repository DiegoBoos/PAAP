class VPerfilPreInversionPlanNegocioEntity {
  VPerfilPreInversionPlanNegocioEntity({
    this.actividadFinancieraId,
    this.actividadFinanciera,
    this.rubroId,
    this.rubro,
    this.unidadId,
    this.unidad,
    this.year,
    this.cantidad,
    this.valor,
    this.productoId,
    this.tipoCalidadId,
    this.porcentaje,
  });

  String? actividadFinancieraId;
  String? actividadFinanciera;
  String? rubroId;
  String? rubro;
  String? unidadId;
  String? unidad;
  String? year;
  String? cantidad;
  String? valor;
  String? productoId;
  String? tipoCalidadId;
  String? porcentaje;

  VPerfilPreInversionPlanNegocioEntity copyWith(
      {String? actividadFinancieraId,
      String? actividadFinanciera,
      String? rubroId,
      String? rubro,
      String? unidadId,
      String? unidad,
      String? year,
      String? cantidad,
      String? valor,
      String? productoId,
      String? tipoCalidadId,
      String? porcentaje}) {
    return VPerfilPreInversionPlanNegocioEntity(
      actividadFinancieraId:
          actividadFinancieraId ?? this.actividadFinancieraId,
      actividadFinanciera: actividadFinanciera ?? this.actividadFinanciera,
      rubroId: rubroId ?? this.rubroId,
      rubro: rubro ?? this.rubro,
      unidadId: unidadId ?? this.unidadId,
      unidad: unidad ?? this.unidad,
      year: year ?? this.year,
      cantidad: cantidad ?? this.cantidad,
      valor: valor ?? this.valor,
      productoId: productoId ?? this.productoId,
      tipoCalidadId: tipoCalidadId ?? this.tipoCalidadId,
      porcentaje: porcentaje ?? this.porcentaje,
    );
  }

  Map<String, dynamic> toJson() => {
        "ActividadFinancieraId": actividadFinancieraId,
        "ActividadFinanciera": actividadFinanciera,
        "RubroId": rubroId,
        "Rubro": rubro,
        "UnidadId": unidadId,
        "Unidad": unidad,
        "Year": year,
        "Cantidad": cantidad,
        "Valor": valor,
        "ProductoId": productoId,
        "TipoCalidadId": tipoCalidadId,
        "Porcentaje": porcentaje
      };
}
