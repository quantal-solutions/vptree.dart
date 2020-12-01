import 'priority_queue_item.dart';
import 'space_point.dart';

class PriorityQueue {
  var size = 5;
  var contents = List<PriorityQueueItem>();
  
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

  double insert(SpacePoint data, double priority) {
    var index = binaryIndexOf(priority);
    if (index < 0) index = -1 - index;
    if (index < size) {
      contents.insert(index, PriorityQueueItem(data, priority));
      if (contents.length > size) {
        contents.removeLast();
      }
    }
    return contents.length == size ? contents[contents.length-1].priority : null;
  }

  List<PriorityQueueItem> list() {
    return List<PriorityQueueItem>.from(contents.map((item) => PriorityQueueItem(item.data, item.priority)));
  }
}
