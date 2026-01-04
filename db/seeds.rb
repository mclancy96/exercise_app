# Seed file for exercise_app
# Idempotent seeds for core records based on db/schema.rb

ActiveRecord::Base.transaction do # rubocop:disable Metrics/BlockLength
  puts "Seeding exercises..."
  push_up = Exercise.find_or_create_by!(name: "Push Up") do |e|
    e.description = "A bodyweight pressing movement"
  end

  squat = Exercise.find_or_create_by!(name: "Squat") do |e|
    e.description = "A bilateral lower-body compound movement"
  end

  plank = Exercise.find_or_create_by!(name: "Plank") do |e|
    e.description = "Isometric core hold"
  end

  puts "Seeding routines..."
  full_body = Routine.find_or_create_by!(name: "Full Body")
  strength = Routine.find_or_create_by!(name: "Strength Split")

  puts "Seeding routine_exercises..."
  RoutineExercise.find_or_create_by!(routine: full_body, exercise: push_up,
                                     day_of_week: "monday") do |re|
    re.order = 1
    re.sets = 3
    re.reps = 12
    re.rep_unit = "reps"
  end

  RoutineExercise.find_or_create_by!(routine: full_body, exercise: squat,
                                     day_of_week: "monday") do |re|
    re.order = 2
    re.sets = 4
    re.reps = 8
    re.rep_unit = "reps"
  end

  RoutineExercise.find_or_create_by!(routine: full_body, exercise: plank,
                                     day_of_week: "wednesday") do |re|
    re.order = 1
    re.sets = 3
    re.reps = 60
    re.rep_unit = "seconds"
  end

  puts "Seeding workouts..."
  Workout.find_or_create_by!(routine: full_body, day_of_week: 1) do |w|
    w.start_time = Time.current.change(hour: 7, min: 0)
    w.end_time = Time.current.change(hour: 8, min: 0)
  end

  Workout.find_or_create_by!(routine: strength, day_of_week: 3) do |w|
    w.start_time = Time.current.change(hour: 18, min: 0)
    w.end_time = Time.current.change(hour: 19, min: 0)
  end

  puts "Seeding complete."
end
