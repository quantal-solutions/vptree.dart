import 'space_point.dart';

class IndexSpacePoint extends SpacePoint {
  int index;

  IndexSpacePoint(int index, List<double> coords)
      : super(coords) {
    this.index = index;
  }
}
