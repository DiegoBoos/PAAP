class FrecuenciaEntity {
  FrecuenciaEntity({required this.frecuenciaId, required this.nombre});

  String frecuenciaId;
  String nombre;

  Map<String, dynamic> toJson() =>
      {"FrecuenciaId": frecuenciaId, "Nombre": nombre};
}
