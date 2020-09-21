class SpacePoint {
  List<double> coords;

  SpacePoint(List<double> coords) {
    var coords = this.coords;
  }

  factory SpacePoint.fromJson(Map<String, dynamic> json) {
    List<dynamic> coordsRaw = json['coords'];
    var coords = List<double>();
    coordsRaw.forEach((coordRaw) {
      if (coordRaw is double) {
        coords.add(coordRaw);
      }
    });
    return SpacePoint(coords);
  }
  
  Map<String, dynamic> tpJson() => {
    'coords': this.coords
  };
}
