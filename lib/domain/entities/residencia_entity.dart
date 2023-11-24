class ResidenciaEntity {
  ResidenciaEntity({this.residenciaId, this.nombre});

  String? residenciaId;
  String? nombre;

  Map<String, dynamic> toJson() =>
      {"ResidenciaId": residenciaId, "Nombre": nombre};
}
