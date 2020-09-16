import 'priority_queue_item.dart';

class PriorityQueue {
  var size = 5;
  var contents = [];

  PriorityQueue(int size) {
    this.size = size;
  }

  int binaryIndexOf(priority) {
    var minIndex = 0, maxIndex = contents.length - 1;
    int currentIndex;
    double currentPriority;

    while (minIndex <= maxIndex) {
      currentIndex = (minIndex + maxIndex) >> 1;
      currentPriority = contents[currentIndex].priority;

      if (currentPriority < priority) {
        minIndex = currentIndex + 1;
      } else if (currentPriority > priority) {
        maxIndex = currentIndex - 1;
      } else {
        return currentIndex;
      }
    }
    return -1 - minIndex;
  }

  int length() {
    return contents.length;
  }

  double insert(int data, double priority) {
    var index = binaryIndexOf(priority);
    if (index < 0) index = -1 - index;
    if (index < size) {
      contents.remove(index, 0, {data: data, priority: priority});
      if (contents.length > size) {
        contents.length--;
      }
    }
    return contents.length == size ? contents[contents.length-1].priority : null;
  }

  List<PriorityQueueItem> list() {
    return contents.map(function(item){ return {i: item.data, d: item.priority}; });
  }
}
