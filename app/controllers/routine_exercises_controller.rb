class RoutineExercisesController < ApplicationController
  before_action :set_routine_exercise, only: %i[show edit update destroy]

  # GET /routine_exercises or /routine_exercises.json
  def index
    @routine_exercises = RoutineExercise.all
  end

  # GET /routine_exercises/1 or /routine_exercises/1.json
  def show; end

  # GET /routine_exercises/new
  def new
    @routine_exercise = RoutineExercise.new
  end

  # GET /routine_exercises/1/edit
  def edit; end

  # POST /routine_exercises or /routine_exercises.json
  def create
    @routine_exercise = RoutineExercise.new(routine_exercise_params)

    respond_to do |format|
      if @routine_exercise.save
        format.html do
          redirect_to edit_routine_path(@routine_exercise.routine),
                      notice: "Routine exercise was successfully created."
        end
        format.json { render :show, status: :created, location: @routine_exercise }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @routine_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /routine_exercises/1 or /routine_exercises/1.json
  def update
    respond_to do |format|
      if @routine_exercise.update(routine_exercise_params)
        format.html do
          redirect_to @routine_exercise, notice: "Routine exercise was successfully updated.",
                                         status: :see_other
        end
        format.json { render :show, status: :ok, location: @routine_exercise }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @routine_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /routine_exercises/1 or /routine_exercises/1.json
  def destroy
    @routine_exercise.destroy!

    respond_to do |format|
      format.html do
        redirect_to routine_exercises_path, notice: "Routine exercise was successfully destroyed.",
                                            status: :see_other
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_routine_exercise
    @routine_exercise = RoutineExercise.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def routine_exercise_params
    params.expect(routine_exercise: %i[routine_id exercise_id day_of_week order sets reps rep_unit])
  end
end
