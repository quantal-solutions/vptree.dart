
import 'space_point.dart';

class PriorityQueueItem {
  SpacePoint data;
  double priority;

  PriorityQueueItem(SpacePoint data, double priority) {
    this.data = data;
    this.priority = priority;
  }
}