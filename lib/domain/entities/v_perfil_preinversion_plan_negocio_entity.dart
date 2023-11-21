class VPerfilPreInversionPlanNegocioEntity {
  VPerfilPreInversionPlanNegocioEntity({
    required this.actividadFinancieraId,
    required this.actividadFinanciera,
    required this.rubroId,
    required this.rubro,
    required this.unidadId,
    required this.unidad,
    required this.year,
    required this.cantidad,
    required this.valor,
    this.productoId,
    this.tipoCalidadId,
    required this.porcentaje,
  });

  String actividadFinancieraId;
  String actividadFinanciera;
  String rubroId;
  String rubro;
  String unidadId;
  String unidad;
  String year;
  String cantidad;
  String valor;
  String? productoId;
  String? tipoCalidadId;
  String porcentaje;

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
