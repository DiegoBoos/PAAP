import '../../domain/entities/beneficio_entity.dart';

class BeneficioModel extends BeneficioEntity {
  BeneficioModel({required String beneficioId, String? nombre})
      : super(beneficioId: beneficioId, nombre: nombre ?? '');

  factory BeneficioModel.fromJson(Map<String, dynamic> json) => BeneficioModel(
        beneficioId: json["BeneficioId"],
        nombre: json["Nombre"],
      );
}
