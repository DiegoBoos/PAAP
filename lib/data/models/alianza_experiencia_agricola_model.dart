import 'package:paap/domain/entities/alianza_experiencia_agricola_entity.dart';

class AlianzaExperienciaAgricolaModel extends AlianzaExperienciaAgricolaEntity {
  AlianzaExperienciaAgricolaModel({
    required String tipoActividadProductivaId,
    required String beneficiarioId,
    required String frecuenciaId,
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
  }) : super(
          tipoActividadProductivaId: tipoActividadProductivaId,
          beneficiarioId: beneficiarioId,
          frecuenciaId: frecuenciaId,
          areaCultivo: areaCultivo ?? '',
          cantidadProducida: cantidadProducida ?? '',
          cantidadVendida: cantidadVendida ?? '',
          cantidadAutoconsumo: cantidadAutoconsumo ?? '',
          costoImplementacion: costoImplementacion ?? '',
          valorJornal: valorJornal ?? '',
          totalIngresoNeto: totalIngresoNeto ?? '',
          areaPasto: areaPasto ?? '',
          areaSinUso: areaSinUso ?? '',
          areaReservaConservacion: areaReservaConservacion ?? '',
          areaImplementacion: areaImplementacion ?? '',
          totalAreaPredio: totalAreaPredio ?? '',
          recordStatus: recordStatus ?? '',
        );

  factory AlianzaExperienciaAgricolaModel.fromJson(Map<String, dynamic> json) =>
      AlianzaExperienciaAgricolaModel(
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
}
