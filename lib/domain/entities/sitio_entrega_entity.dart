class SitioEntregaEntity {
  SitioEntregaEntity({required this.sitioEntregaId, required this.nombre});

  String sitioEntregaId;
  String nombre;

  factory SitioEntregaEntity.fromJson(Map<String, dynamic> json) =>
      SitioEntregaEntity(
          sitioEntregaId: json["SitioEntregaId"], nombre: json["Nombre"]);

  Map<String, dynamic> toJson() =>
      {"SitioEntregaId": sitioEntregaId, "Nombre": nombre};
}
