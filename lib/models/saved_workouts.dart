//list of lists retrived from LS to display on main setup page
import 'package:workout_timer/models/workout_list.dart';

class SavedWorkouts {
  List<WorkoutList> items = [];

  add(WorkoutList newItem) {
    items.add(newItem);
  }

  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}
