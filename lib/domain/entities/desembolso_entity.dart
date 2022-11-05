class DesembolsoEntity {
  DesembolsoEntity({required this.desembolsoId, required this.nombre});

  String desembolsoId;
  String nombre;

  factory DesembolsoEntity.fromJson(Map<String, dynamic> json) =>
      DesembolsoEntity(
          desembolsoId: json["DesembolsoId"], nombre: json["Nombre"]);

  Map<String, dynamic> toJson() =>
      {"DesembolsoId": desembolsoId, "Nombre": nombre};
}
