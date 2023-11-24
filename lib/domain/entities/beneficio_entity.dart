class BeneficioEntity {
  BeneficioEntity({this.beneficioId, this.nombre});

  String? beneficioId;
  String? nombre;

  Map<String, dynamic> toJson() =>
      {"BeneficioId": beneficioId, "Nombre": nombre};
}
