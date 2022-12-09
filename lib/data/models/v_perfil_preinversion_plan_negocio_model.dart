import '../../domain/entities/v_perfil_preinversion_plan_negocio_entity.dart';

class VPerfilPreInversionPlanNegocioModel
    extends VPerfilPreInversionPlanNegocioEntity {
  VPerfilPreInversionPlanNegocioModel({
    required String actividadFinancieraId,
    required String actividadFinanciera,
    required String rubroId,
    required String rubro,
    required String unidadId,
    required String unidad,
    required String year,
    required String cantidad,
    required String valor,
    String? productoId,
    String? tipoCalidadId,
    required String porcentaje,
  }) : super(
          actividadFinancieraId: actividadFinancieraId,
          actividadFinanciera: actividadFinanciera,
          rubroId: rubroId,
          rubro: rubro,
          unidadId: unidadId,
          unidad: unidad,
          year: year,
          cantidad: cantidad,
          valor: valor,
          productoId: productoId,
          tipoCalidadId: tipoCalidadId,
          porcentaje: porcentaje,
        );

  factory VPerfilPreInversionPlanNegocioModel.fromJson(
          Map<String, dynamic> json) =>
      VPerfilPreInversionPlanNegocioModel(
        actividadFinancieraId: json['ActividadFinancieraId'],
        actividadFinanciera: json['ActividadFinanciera'],
        rubroId: json['RubroId'],
        rubro: json['Rubro'],
        unidadId: json['UnidadId'],
        unidad: json['Unidad'],
        year: json['Year'],
        cantidad: json['Cantidad'],
        valor: json['Valor'],
        productoId: json['ProductoId'],
        tipoCalidadId: json['TipoCalidadId'],
        porcentaje: json['Porcentaje'].toString(),
      );

  @override
  Map<String, dynamic> toJson() => {
        "actividadFinancieraId": actividadFinancieraId,
        "RubroId": rubroId,
        "ActividadFinanciera": actividadFinanciera,
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
