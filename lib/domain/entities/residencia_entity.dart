class ResidenciaEntity {
  ResidenciaEntity({required this.residenciaId, required this.nombre});

  String residenciaId;
  String nombre;

  factory ResidenciaEntity.fromJson(Map<String, dynamic> json) =>
      ResidenciaEntity(
          residenciaId: json["ResidenciaId"], nombre: json["Nombre"]);

  Map<String, dynamic> toJson() =>
      {"ResidenciaId": residenciaId, "Nombre": nombre};
}
