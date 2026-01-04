class WorkoutsController < ApplicationController
  before_action :set_routine

  def show
    @day = current_day

    @routine_exercises = routine_exercises_for_day(@day)
    return redirect_no_exercises_for_day if @routine_exercises.empty?

    step, idx = step_and_idx

    @current_round_exercises = current_round_exercises_for_step(@routine_exercises, step)
    return redirect_workout_complete if @current_round_exercises.empty?

    idx = normalize_idx(idx, @current_round_exercises.size)

    @current_exercise, @next_params = current_exercise_and_next_params(@current_round_exercises,
                                                                       step, idx)
  end

  private

  def set_routine
    @routine = Routine.find(params[:id])
  end

  def current_day
    Time.use_zone("America/New_York") { Date.current.strftime("%A") }.downcase
  end

  def routine_exercises_for_day(day)
    @routine.routine_exercises
            .where(day_of_week: day)
            .includes(:exercise)
            .order(:order)
  end

  def redirect_no_exercises_for_day
    redirect_to routines_path,
                notice: "No exercises scheduled for #{current_day.titleize}" and return
  end

  def step_and_idx
    step = (params[:step] || 1).to_i
    idx = (params[:idx] || 0).to_i
    [step, idx]
  end

  def current_round_exercises_for_step(routine_exercises, step)
    routine_exercises.select { |re| re.sets.present? && re.sets >= step }
  end

  def redirect_workout_complete
    redirect_to routines_path, notice: "Workout complete" and return
  end

  def normalize_idx(idx, size)
    idx = 0 if idx.negative?
    idx = size - 1 if idx >= size
    idx
  end

  def current_exercise_and_next_params(current_round_exercises, step, idx)
    current = current_round_exercises[idx]

    next_params = if idx + 1 < current_round_exercises.size
                    { step: step, idx: idx + 1 }
                  else
                    { step: step + 1, idx: 0 }
                  end

    [current, next_params]
  end
end
