class VpTreeNode {
  int i;
  double min;
  double max;
  double mu;
  List<VpTreeNode> L;
  List<VpTreeNode> R;
  double dist;
  bool isReady;

  VpTreeNode(int i) {
    this.i = i;
  }
}
