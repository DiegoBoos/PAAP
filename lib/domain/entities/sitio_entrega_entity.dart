class SitioEntregaEntity {
  SitioEntregaEntity({required this.sitioEntregaId, required this.nombre});

  String sitioEntregaId;
  String nombre;

  Map<String, dynamic> toJson() =>
      {"SitioEntregaId": sitioEntregaId, "Nombre": nombre};
}
