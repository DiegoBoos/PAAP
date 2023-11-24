class DesembolsoEntity {
  DesembolsoEntity({this.desembolsoId, this.nombre});

  String? desembolsoId;
  String? nombre;

  Map<String, dynamic> toJson() =>
      {"DesembolsoId": desembolsoId, "Nombre": nombre};
}
