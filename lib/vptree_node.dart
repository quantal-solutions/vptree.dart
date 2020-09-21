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
    var i = json['i'];
    var vpTreeNode = VpTreeNode(i);
    vpTreeNode.min = json['min'];
    vpTreeNode.max = json['max'];
    vpTreeNode.mu = json['mu'];

    List<dynamic> treeNodesLRaw = json['L'];
    var treeNodesL = List<VpTreeNode>();
    treeNodesLRaw.forEach((treeNodeRaw) {
      var treeNode = VpTreeNode.fromJson(treeNodeRaw);
      treeNodesL.add(treeNode);
    });
    vpTreeNode.L = treeNodesL;

    List<dynamic> treeNodesRRaw = json['R'];
    var treeNodesR = List<VpTreeNode>();
    treeNodesRRaw.forEach((treeNodeRaw) {
      var treeNode = VpTreeNode.fromJson(treeNodeRaw);
      treeNodesR.add(treeNode);
    });
    vpTreeNode.R = treeNodesR;

    vpTreeNode.dist = json['dist'];
    vpTreeNode.isReady = json['isReady'];

    return vpTreeNode;
  }

  Map<String, dynamic> toJson() => { 
    'i': this.i,
    'min': this.min, 
    'max': this.max, 
    'mu': this.mu, 
    'L': this.L, 
    'R': this.R, 
    'dist': this.dist, 
    'isReady': this.isReady 
  };
}
