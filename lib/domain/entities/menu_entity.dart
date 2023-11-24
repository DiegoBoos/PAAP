class MenuEntity {
  MenuEntity({
    this.menuId,
    this.nombre,
    this.ruta,
    this.icono,
    this.orden,
    this.menuPadre,
    this.tipoMenuId,
  });

  String? menuId;
  String? nombre;
  String? ruta;
  String? icono;
  String? orden;
  String? menuPadre;
  String? tipoMenuId;

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
