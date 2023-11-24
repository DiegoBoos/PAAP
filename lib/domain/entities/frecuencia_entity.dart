class FrecuenciaEntity {
  FrecuenciaEntity({this.frecuenciaId, this.nombre});

  String? frecuenciaId;
  String? nombre;

  Map<String, dynamic> toJson() =>
      {"FrecuenciaId": frecuenciaId, "Nombre": nombre};
}
