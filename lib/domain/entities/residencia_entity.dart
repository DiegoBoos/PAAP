class ResidenciaEntity {
  ResidenciaEntity({required this.residenciaId, required this.nombre});

  String residenciaId;
  String nombre;

  Map<String, dynamic> toJson() =>
      {"ResidenciaId": residenciaId, "Nombre": nombre};
}
