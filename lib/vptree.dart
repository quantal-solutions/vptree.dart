class VPTreeFactory {
  partition(list, left, right, pivotIndex, comp) {
    var pivotValue = list[pivotIndex];
    var swap = list[pivotIndex];
    list[pivotIndex] = list[right];
    list[right] = swap;
    var storeIndex = left;
    for (var i = left; i < right; i++) {
      if (comp(list[i], pivotValue)) {
        swap = list[storeIndex];
        list[storeIndex] = list[i];
        list[i] = swap;
        storeIndex++;
      }
    }
    swap = list[right];
    list[right] = list[storeIndex];
    list[storeIndex] = swap;
    return storeIndex;
  }

  medianOf3(list, a, b, c, comp) {
    var A = list[a], B = list[b], C = list[c];
    return comp(A, B)
        ? comp(B, C) ? b : comp(A, C) ? c : a
        : comp(A, C) ? a : comp(B, C) ? c : b;
  }
}
