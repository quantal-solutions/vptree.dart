class VpTreeNode {
  int i;
  double min;
  double max;
  double mu;
  List<VpTreeNode> L;
  List<VpTreeNode> R;
  double dist;
  bool isReady = false;

  VpTreeNode(int i) {
    this.i = i;
  }
  factory VpTreeNode.fromJson(Map<String, dynamic> json) {
    List<dynamic> elementsColumnOne = json['L'];
    List<dynamic> elementsColumnTwo = json['R'];
    elementsColumnOne.forEach((elementContents) {
      var coords = List<int>();
      if (elementContents is List) {
        elementContents.forEach((elementContents) {
          if (elementContents is int) {
            coords.add(elementContents);
          }
        });
      }
      List<dynamic> elementsColumnOne = json['treeNodesCol'];
      var treeNodes = List<VpTreeNode>();
      elementsColumnOne.forEach((elementsColumnOne) {
        var treeNode = VpTreeNode.fromJson(elementsColumnOne);
        treeNodes.add(treeNode);
      });
      return VpTreeNode(i);
    });
    Map<String, dynamic> toJson() => {};
  }
}
