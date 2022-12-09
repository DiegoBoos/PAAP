import 'package:paap/domain/entities/experiencia_agricola_entity.dart';

class ExperienciaAgricolaModel extends ExperienciaAgricolaEntity {
  ExperienciaAgricolaModel({
    required String? tipoActividadProductivaId,
    required String? beneficiarioId,
    required String? frecuenciaId,
    required String areaCultivo,
    required String cantidadProducida,
    required String cantidadVendida,
    required String cantidadAutoconsumo,
    required String costoImplementacion,
    required String valorJornal,
    required String totalIngresoNeto,
    required String areaPasto,
    required String areaSinUso,
    required String areaReservaConservacion,
    required String areaImplementacion,
    required String totalAreaPredio,
    String? recordStatus,
  }) : super(
          tipoActividadProductivaId: tipoActividadProductivaId ?? '',
          beneficiarioId: beneficiarioId ?? '',
          frecuenciaId: frecuenciaId ?? '',
          areaCultivo: areaCultivo,
          cantidadProducida: cantidadProducida,
          cantidadVendida: cantidadVendida,
          cantidadAutoconsumo: cantidadAutoconsumo,
          costoImplementacion: costoImplementacion,
          valorJornal: valorJornal,
          totalIngresoNeto: totalIngresoNeto,
          areaPasto: areaPasto,
          areaSinUso: areaSinUso,
          areaReservaConservacion: areaReservaConservacion,
          areaImplementacion: areaImplementacion,
          totalAreaPredio: totalAreaPredio,
          recordStatus: recordStatus ?? '',
        );

  factory ExperienciaAgricolaModel.fromJson(Map<String, dynamic> json) =>
      ExperienciaAgricolaModel(
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

  @override
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
