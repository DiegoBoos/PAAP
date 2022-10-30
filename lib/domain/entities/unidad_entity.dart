class UnidadEntity {
  UnidadEntity({
    required this.unidadId,
    required this.nombre,
    required this.simbolo,
  });

  String unidadId;
  String nombre;
  String simbolo;

  factory UnidadEntity.fromJson(Map<String, dynamic> json) => UnidadEntity(
        unidadId: json["UnidadId"],
        nombre: json["Nombre"],
        simbolo: json["Simbolo"],
      );

  Map<String, dynamic> toJson() => {
        "UnidadId": unidadId,
        "Nombre": nombre,
        "Simbolo": simbolo,
      };
}
