class RoutinesController < ApplicationController
  before_action :set_routine, only: %i[show edit update destroy]

  def index
    @routines = Routine.all
  end

  # GET /routines/1 or /routines/1.json
  def show; end

  # GET /routines/new
  def new
    @routine = Routine.new
  end

  # GET /routines/1/edit
  def edit
    @routine_exercise = RoutineExercise.new(routine: @routine)
  end

  # POST /routines or /routines.json
  def create
    @routine = Routine.new(routine_params)

    respond_to do |format|
      if @routine.save
        format.html { redirect_to @routine, notice: "Routine was successfully created." }
        format.json { render :show, status: :created, location: @routine }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @routine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /routines/1 or /routines/1.json
  def update
    respond_to do |format|
      if @routine.update(routine_params)
        format.html do
          redirect_to @routine, notice: "Routine was successfully updated.", status: :see_other
        end
        format.json { render :show, status: :ok, location: @routine }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @routine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /routines/1 or /routines/1.json
  def destroy
    @routine.destroy!

    respond_to do |format|
      format.html do
        redirect_to routines_path, notice: "Routine was successfully destroyed.", status: :see_other
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_routine
    @routine = Routine.find(params.expect(:id))
    weekday_order = <<~SQL.squish
      CASE LOWER(day_of_week)
        WHEN 'sunday' THEN 0
        WHEN 'monday' THEN 1
        WHEN 'tuesday' THEN 2
        WHEN 'wednesday' THEN 3
        WHEN 'thursday' THEN 4
        WHEN 'friday' THEN 5
        WHEN 'saturday' THEN 6
        ELSE 7
      END
    SQL

    @routine_exercises = @routine&.routine_exercises&.order(Arel.sql("(#{weekday_order})"), :order)
  end

  # Only allow a list of trusted parameters through.
  def routine_params
    params.expect(routine: [:name])
  end
end
