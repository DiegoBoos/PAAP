class NivelEscolarEntity {
  NivelEscolarEntity({
    required this.nivelEscolarId,
    required this.nombre,
    required this.descripcion,
  });

  String nivelEscolarId;
  String nombre;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "NivelEscolarId": nivelEscolarId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
