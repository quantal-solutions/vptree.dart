class SpacePoint {
  List<double> coords;

  SpacePoint(List<double> coords) {
    this.coords = coords;
  }

  factory SpacePoint.fromJson(Map<String, dynamic> json) {
    List<dynamic> coordsRaw = json['coords'];
    var coords = coordsRaw != null
        ? coordsRaw.map((coords) => coords as double).toList()
        : List<double>();
    return SpacePoint(coords);
  }

  Map<String, dynamic> toJson() => {'coords': this.coords};
}
