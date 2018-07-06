class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:create]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def schedule
    @teams = Team.all
    if @teams.size == 16
      @schedules = []
      time_index = 0
      @teams.each_slice(4) do |slice|
        times = avail_times[time_index..(time_index + 1) * 6 - 1]
        new_schedule_teams = []
        schedule_teams = slice.combination(2).to_a
        (0..5).each do |i|
          new_schedule_teams << (schedule_teams[i] << times[i])
        end
        @schedules << new_schedule_teams
        time_index = time_index + 1
      end
    else
      @error = "Sorry, team size is not 16, please make sure the team size is equal to 16"
    end
    if @error
      render json: {error: @error}
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name)
    end

    def avail_times
      times = []
      (0..4).each do |i|
        times << (Time.current + i.day).change(hour: 21)
        times << (Time.current + i.day).change(hour: 23)
      end
      times
    end
end
