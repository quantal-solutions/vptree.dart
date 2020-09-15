class PriorityQueue {
		var size = 5;
		var contents = [];

		binaryIndexOf(priority) {
			var minIndex = 0,
				maxIndex = contents.length - 1,
				currentIndex,
				currentElement;

			while (minIndex <= maxIndex) {
				currentIndex = (minIndex + maxIndex) >> 1;
				currentElement = contents[currentIndex].priority;
				 
				if (currentElement < priority) {
					minIndex = currentIndex + 1;
				}
				else if (currentElement > priority) {
					maxIndex = currentIndex - 1;
				}
				else {
					return currentIndex;
				}
			}

			return -1 - minIndex;
		}

		var api = {
			// This breaks IE8 compatibility. Who cares ?
			int length() {
				return contents.length;
			},

			insert(int data, double priority) {
				var index = binaryIndexOf(priority);
				if (index < 0) index = -1 - index;
				if (index < size) {
					contents.splice(index, 0, {data: data, priority: priority});
					if (contents.length > size) {
						contents.length--;
					}
				}
				return contents.length === size ? contents[contents.length-1].priority : undefined;
			},

			List<PriorityQueue.Item> list() {
				return contents.map(function(item){ return {i: item.data, d: item.priority}; });
			}
		};

		return api;
	}
