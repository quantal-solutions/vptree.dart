class SpacePoint {
  List<int> coords;

  SpacePoint(List<int> coords) {
    var coords = this.coords;
  }

  factory SpacePoint.fromJson(Map<String, dynamic> json) {
    List<dynamic> coordsRaw = json['coords'];
    var coords = List<int>();
    coordsRaw.forEach((coordRaw) {
      if (coordRaw is int) {
        coords.add(coordRaw);
      }
    });
    return SpacePoint(coords);
  }
  
  Map<String, dynamic> tpJson() => {
    'coords': this.coords
  };
}
