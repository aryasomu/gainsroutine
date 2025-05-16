import SwiftUI

struct ContentView: View {
    @State private var isShowingWorkouts = false
    
    var body: some View {
        if isShowingWorkouts {
            WorkoutSelectionView()
        } else {
            HomePageView(enterAction: {
                self.isShowingWorkouts = true
            })
        }
    }
}

struct HomePageView: View {
    let enterAction: () -> Void
    
    var body: some View {
        VStack {
            Text("GainsRoutine")
                .font(.largeTitle)
                .padding()
            
            Button(action: enterAction) {
                Text("Enter")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}

struct WorkoutSelectionView: View {
    var body: some View {
        VStack {
            NavigationView {
                List {
                    NavigationLink(destination: WorkoutDetailsView(workoutType: "Legs")) {
                        Text("Legs")
                    }
                    NavigationLink(destination: WorkoutDetailsView(workoutType: "Back")) {
                        Text("Back")
                    }
                    NavigationLink(destination: WorkoutDetailsView(workoutType: "Arms")) {
                        Text("Arms")
                    }
                    NavigationLink(destination: WorkoutDetailsView(workoutType: "Chest")) {
                        Text("Chest")
                    }
                }
                .navigationTitle("Workout Selection")
            }
        }
    }
}

struct WorkoutDetailsView: View {
    @State private var workoutName = ""
    @State private var sets = ""
    @State private var reps = ""
    @State private var workoutDate = Date()
    
    let workoutType: String
    
    var body: some View {
        VStack {
            Text("Enter \(workoutType) Workout Details")
                .font(.headline)
                .padding()
            
            TextField("Workout Name", text: $workoutName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Sets", text: $sets)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Reps", text: $reps)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            DatePicker("Workout Date", selection: $workoutDate, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .padding()
            
            Button(action: {
                saveWorkout()
            }) {
                Text("Save")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
    }
    
    private func saveWorkout() {
        guard let setsCount = Int(sets), let repsCount = Int(reps) else {
            print("Invalid sets or reps count.")
            return
        }
        
        let workoutData: [String: Any] = [
            "workoutName": workoutName,
            "sets": setsCount,
            "reps": repsCount,
            "workoutDate": workoutDate
        ]
        
        var savedWorkouts = UserDefaults.standard.array(forKey: workoutType) as? [[String: Any]] ?? []
        savedWorkouts.append(workoutData)
        UserDefaults.standard.set(savedWorkouts, forKey: workoutType)
        
        print("Workout saved successfully.")
        
    }
}
