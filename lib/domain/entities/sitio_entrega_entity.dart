class SitioEntregaEntity {
  SitioEntregaEntity({this.sitioEntregaId, this.nombre});

  String? sitioEntregaId;
  String? nombre;

  Map<String, dynamic> toJson() =>
      {"SitioEntregaId": sitioEntregaId, "Nombre": nombre};
}
