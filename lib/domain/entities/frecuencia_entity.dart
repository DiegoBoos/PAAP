class FrecuenciaEntity {
  FrecuenciaEntity({required this.frecuenciaId, required this.nombre});

  String frecuenciaId;
  String nombre;

  factory FrecuenciaEntity.fromJson(Map<String, dynamic> json) =>
      FrecuenciaEntity(
          frecuenciaId: json["FrecuenciaId"], nombre: json["Nombre"]);

  Map<String, dynamic> toJson() =>
      {"FrecuenciaId": frecuenciaId, "Nombre": nombre};
}
