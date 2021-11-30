import 'package:localstorage/localstorage.dart';
import 'package:workout_timer/models/saved_workouts.dart';
import 'package:workout_timer/models/workout_list.dart';

class LS {
  SavedWorkouts list = SavedWorkouts();
  LocalStorage storage = LocalStorage('workout_app');

  _saveToStorage(WorkoutList newItem) {
    list.add(newItem);
    storage.setItem('workouts', list.toJSONEncodable());
  }

  addNewWorkout(WorkoutList newItem, Function callback) {
    _saveToStorage(newItem);
    callback(false);
    print(newItem.title);
  }
}
