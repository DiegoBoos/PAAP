class MenuEntity {
  MenuEntity({
    required this.menuId,
    required this.nombre,
    required this.ruta,
    required this.icono,
    required this.orden,
    required this.menuPadre,
    required this.tipoMenuId,
  });

  final String menuId;
  final String nombre;
  final String ruta;
  final String icono;
  final String orden;
  final String menuPadre;
  final String tipoMenuId;

  factory MenuEntity.fromJson(Map<String, dynamic> json) => MenuEntity(
        menuId: json["MenuId"],
        nombre: json["Nombre"],
        ruta: json["Ruta"],
        icono: json["Icono"],
        orden: json["Orden"],
        menuPadre: json["MenuPadre"],
        tipoMenuId: json["TipoMenuId"],
      );

  Map<String, dynamic> toJson() => {
        "MenuId": menuId,
        "Nombre": nombre,
        "Ruta": ruta,
        "Icono": icono,
        "Orden": orden,
        "MenuPadre": menuPadre,
        "TipoMenuId": tipoMenuId,
      };
}
