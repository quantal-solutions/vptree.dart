import './vptree.dart';

class VpTreeFactory {

  build(List<List<int>> element, int bucketSize, Function(List<int>,List<int>) 
  computeDistanceCallback) {
    var bucketSize = 0, vptree, vptreeb, vptree2, vptreeb2;
  }

  load(List<List<int>> element, String stringifiedTree, Function(List<int>,List<int>) 
  computeDistanceCallback) {
    return new VpTreeFactory();
  }

  infComparator(int a, int b) {
    return a < b;
  }

  select(List array, int k, Function(int, int) infComparator) {}

}
