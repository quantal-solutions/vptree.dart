import 'dart:convert';
import './priority_queue.dart';
import './vptree_node.dart';
import './priority_queue_item.dart';
import './space_point.dart';

class VpTree {
  List<SpacePoint> spacePoints;
  List<VpTreeNode> treeNodes;
  Function(SpacePoint, SpacePoint) computeDistanceCallback;
  int comparisons;

  VpTree(List<SpacePoint> spacePoints, List<VpTreeNode> treeNodes,
      Function(SpacePoint, SpacePoint) computeDistanceCallback) {
    this.spacePoints = spacePoints;
    this.treeNodes = treeNodes;
    this.computeDistanceCallback = computeDistanceCallback;
  }

  List<PriorityQueueItem> search(
      SpacePoint querySpacePoint, int searchQty, double maxDistance) {
    var modMaxDistance = maxDistance;
    var priorityQueue = PriorityQueue(searchQty);
    var spacePoints = this.spacePoints;
    var computeDistanceCallback = this.computeDistanceCallback;
    var comparisons = 0;

    doSearch(List<VpTreeNode> treeNodes) {
      if (treeNodes == null) return;

      if (treeNodes.length > 1) {
        for (var i = 0, n = treeNodes.length; i < n; i++) {
          comparisons++;
          var elementID = treeNodes[i].i,
              element = spacePoints[elementID],
              elementDist = computeDistanceCallback(querySpacePoint, element);
          if (elementDist < modMaxDistance) {
            var insertedDistance = priorityQueue.insert(elementID, elementDist);
            modMaxDistance =
                insertedDistance != null ? insertedDistance : modMaxDistance;
          }
        }
        return;
      }

      var id = treeNodes[0].i, p = spacePoints[id];
      var dist = computeDistanceCallback(querySpacePoint, p);

      comparisons++;
      if (dist < modMaxDistance) {
        var insertedDistance = priorityQueue.insert(id, dist);
        modMaxDistance =
            insertedDistance != null ? insertedDistance : modMaxDistance;
      }

      var mu = treeNodes[0].mu;
      var L = treeNodes[0].L;
      var R = treeNodes[0].R;
      if (!treeNodes[0].isReady) return;
      if (dist < mu) {
        if (L != null && treeNodes[0].min - modMaxDistance < dist) doSearch(L);
        if (R != null && mu - modMaxDistance < dist) doSearch(R);
      } else {
        if (R != null && dist < treeNodes[0].max + maxDistance) doSearch(R);
        if (L != null && dist < mu + maxDistance) doSearch(L);
      }
    }

    doSearch(this.treeNodes);
    this.comparisons = comparisons;
    return priorityQueue.list();
  }

  String stringify() {
    return json.encode(toJson());
  }

  factory VpTree.fromJson(Map<String, dynamic> json,
      Function(SpacePoint, SpacePoint) computeDistanceCallback) {
    List<dynamic> elementsRaw = json['spacePoints'];
    var spacePoints = List<SpacePoint>();
    elementsRaw.forEach((elementContents) {
      var coords = List<int>();
      if (elementContents is List) {
        elementContents.forEach((elementContents) {
          if (elementContents is int) {
            coords.add(elementContents);
          }
        });
      }
      elementContents.add(coords);
    });
    List<dynamic> treeNodesRaw = json['treeNodes'];
    var treeNodes = List<VpTreeNode>();
    treeNodesRaw.forEach((treeNodeRaw) {
      var treeNode = VpTreeNode.fromJson(treeNodeRaw);
      treeNodes.add(treeNode);
    });
    return VpTree(spacePoints, treeNodes, computeDistanceCallback);
  }

  Map<String, dynamic> toJson() => {
    'spacePoints': this.spacePoints, 
    'treeNodes': this.treeNodes.map((treeNodes) => treeNodes.toJson())
  };
}
