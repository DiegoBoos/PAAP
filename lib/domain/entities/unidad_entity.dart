class UnidadEntity {
  UnidadEntity({
    required this.unidadId,
    required this.nombre,
    required this.simbolo,
  });

  String unidadId;
  String nombre;
  String simbolo;

  Map<String, dynamic> toJson() => {
        "UnidadId": unidadId,
        "Nombre": nombre,
        "Simbolo": simbolo,
      };
}
