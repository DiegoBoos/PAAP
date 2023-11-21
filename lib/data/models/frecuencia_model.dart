import 'package:paap/domain/entities/frecuencia_entity.dart';

class FrecuenciaModel extends FrecuenciaEntity {
  FrecuenciaModel({required String frecuenciaId, String? nombre})
      : super(frecuenciaId: frecuenciaId, nombre: nombre ?? '');

  factory FrecuenciaModel.fromJson(Map<String, dynamic> json) =>
      FrecuenciaModel(
          frecuenciaId: json["FrecuenciaId"], nombre: json["Nombre"]);
}
