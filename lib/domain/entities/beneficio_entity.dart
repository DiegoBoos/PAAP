class BeneficioEntity {
  BeneficioEntity({required this.beneficioId, required this.nombre});

  String beneficioId;
  String nombre;

  factory BeneficioEntity.fromJson(Map<String, dynamic> json) =>
      BeneficioEntity(beneficioId: json["BeneficioId"], nombre: json["Nombre"]);

  Map<String, dynamic> toJson() =>
      {"BeneficioId": beneficioId, "Nombre": nombre};
}
