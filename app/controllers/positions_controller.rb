class PositionsController < ApplicationController
  before_action :set_position, only: [:show, :edit, :update, :destroy]

  # GET /positions
  # GET /positions.json
  def index
    @positions = Position.all
    @vehicles = Vehicle.all
  end

  def routes
    vehicle_id = params[:id]
    start_date = params[:startDate]
    end_date = params[:endDate]
    imei = Vehicle.all.where(id: vehicle_id)[0].imei
    positions = Position.all.where("created_at BETWEEN ? AND ?", start_date, end_date).where(imei: imei)
    speed = positions.pluck(:speed)
    date = positions.pluck(:created_at)
    len = positions.all.size
    graph = Array.new
    for i in 0..len-1
      input = {"year": i,"value": speed[i]}
      graph.push(input)
    end

    coordinateAry = Array.new
    distanceAry = Array.new

    for i in 0..len-1
      dict = {lat: positions[i].latitude, lng: positions[i].longitude}
      coordinateAry.push(dict)
    end
    #calculate distance between two location
    for i in 0..len-2
      start_point = coordinateAry[i][:lat], coordinateAry[i][:lng]
      end_point = coordinateAry[i+1][:lat], coordinateAry[i+1][:lng]
      distance = Geocoder::Calculations.distance_between(start_point, end_point, :units => :km)
      distanceAry.push(distance)
    end

    total_distance = distanceAry.inject(0){|sum,x| sum + x }
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: [coordinateAry, total_distance, speed, graph] }
    end
  end

  def marker
    all_vehicles = Position.getPositions()
    #sent all_vehicles back to ajax call
    respond_to do |format|
      format.html
      format.json { render json: all_vehicles }
    end
  end
  # GET /positions/1
  # GET /positions/1.json
  def show
  end

  # GET /positions/new
  def new
    @position = Position.new
  end

  # GET /positions/1/edit
  def edit
  end

  # POST /positions
  # POST /positions.json
  def create
    @position = Position.new(position_params)

    respond_to do |format|
      if @position.save
        format.html { redirect_to @position, notice: 'Position was successfully created.' }
        format.json { render :show, status: :created, location: @position }
      else
        format.html { render :new }
        format.json { render json: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /positions/1
  # PATCH/PUT /positions/1.json
  def update
    respond_to do |format|
      if @position.update(position_params)
        format.html { redirect_to @position, notice: 'Position was successfully updated.' }
        format.json { render :show, status: :ok, location: @position }
      else
        format.html { render :edit }
        format.json { render json: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /positions/1
  # DELETE /positions/1.json
  def destroy
    @position.destroy
    respond_to do |format|
      format.html { redirect_to positions_url, notice: 'Position was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_position
      @position = Position.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def position_params
      params.require(:position).permit(:latitude, :longitude, :speed, :imei, :period)
    end
end
