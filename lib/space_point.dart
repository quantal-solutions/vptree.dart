class SpacePoint {
  List<int> coords;
  SpacePoint() {
    var coords = this.coords;
  }

  factory SpacePoint.fromJson(Map<String, dynamic> json) {
    List<dynamic> coords = json['points'];
    var vpTreeNode = SpacePoint();
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
