class RoutineExercisesController < ApplicationController
  before_action :set_routine_exercise, only: %i[show edit update destroy]

  def index
    @routine_exercises = RoutineExercise.all
  end

  def show; end

  def new
    @routine_exercise = RoutineExercise.new
  end

  def edit; end

  def create
    @routine_exercise = RoutineExercise.new(routine_exercise_params)

    if @routine_exercise.save
      redirect_to edit_routine_path(@routine_exercise.routine),
                  notice: "Routine exercise was successfully created."
    else
      redirect_to edit_routine_path(@routine_exercise.routine), status: :unprocessable_entity
    end
  end

  def update
    if @routine_exercise.update(routine_exercise_params)
      redirect_to routine_path(@routine_exercise.routine), notice: "Routine exercise was successfully updated.",
                                                           status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @routine = @routine_exercise.routine
    @routine_exercise.destroy!

    respond_to do |format|
      format.html do
        redirect_to routine_path(@routine), notice: "Routine exercise was successfully destroyed.",
                                            status: :see_other
      end
      format.json { head :no_content }
    end
  end

  private

  def set_routine_exercise
    @routine_exercise = RoutineExercise.find(params.expect(:id))
  end

  def routine_exercise_params
    puts params
    params.expect(routine_exercise: %i[routine_id exercise_id day_of_week order sets reps rep_unit])
  end
end
