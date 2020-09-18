class SpacePoint {
  List<int> coords;
  
  SpacePoint(List<int> coords) {
    var coords = this.coords;
  }

  factory SpacePoint.fromJson(Map<String, dynamic> json) {
    List<dynamic> coords = json['points'];
    var vpTreeNode = SpacePoint(coords);
    var point = List<SpacePoint>();
    coords.forEach((coordsAll) {
      var coord = SpacePoint.fromJson(coordsAll);
      point.add(coord);
    });
    return vpTreeNode;
  }
  
  Map<String, dynamic> tpJson() => {
    'coords': this.coords
  };
}
