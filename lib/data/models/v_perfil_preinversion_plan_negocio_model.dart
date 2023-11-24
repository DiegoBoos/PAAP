import '../../domain/entities/v_perfil_preinversion_plan_negocio_entity.dart';

class VPerfilPreInversionPlanNegocioModel
    extends VPerfilPreInversionPlanNegocioEntity {
  VPerfilPreInversionPlanNegocioModel({
    String? actividadFinancieraId,
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
}
