class DesembolsoEntity {
  DesembolsoEntity({required this.desembolsoId, required this.nombre});

  String desembolsoId;
  String nombre;

  Map<String, dynamic> toJson() =>
      {"DesembolsoId": desembolsoId, "Nombre": nombre};
}
