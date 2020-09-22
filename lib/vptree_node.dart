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
    var treeNodesL = treeNodesLRaw != null
      ? treeNodesLRaw.map((treeNode) => VpTreeNode.fromJson(treeNode)).toList()
      : List<VpTreeNode>();
    vpTreeNode.L = treeNodesL;

    List<dynamic> treeNodesRRaw = json['R'];
    var treeNodesR = treeNodesRRaw != null
      ? treeNodesRRaw.map((treeNode) => VpTreeNode.fromJson(treeNode)).toList()
      : List<VpTreeNode>();
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
