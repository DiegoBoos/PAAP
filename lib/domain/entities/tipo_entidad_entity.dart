class TipoEntidadEntity {
  TipoEntidadEntity({required this.tipoEntidadId, required this.nombre});

  String tipoEntidadId;
  String nombre;

  factory TipoEntidadEntity.fromJson(Map<String, dynamic> json) =>
      TipoEntidadEntity(
          tipoEntidadId: json["TipoEntidadId"], nombre: json["Nombre"]);

  Map<String, dynamic> toJson() =>
      {"TipoEntidadId": tipoEntidadId, "Nombre": nombre};
}
