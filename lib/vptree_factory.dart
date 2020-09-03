import './vptree.dart';

class VPTreeFactory {
  build(List<dynamic> element, int bucketSize, computeDistanceCallback) {
    var bucketSize = 0, vptree, vptreeb, vptree2, vptreeb2;
    return VpTree();
  }

  load(List<dynamic> element, int bucketSize, computeDistanceCallback) {
    return new VPTreeFactory();
  }

  infComparator(a, b) {
    return a < b;
  }

  select(List array, int k, infComparator) {}
}
