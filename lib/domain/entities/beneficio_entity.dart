class BeneficioEntity {
  BeneficioEntity({required this.beneficioId, required this.nombre});

  String beneficioId;
  String nombre;

  Map<String, dynamic> toJson() =>
      {"BeneficioId": beneficioId, "Nombre": nombre};
}
