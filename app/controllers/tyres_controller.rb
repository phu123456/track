class TyresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tyre, only: [:show, :edit, :update, :destroy]
  # GET /tyres
  # GET /tyres.json
  def index
    @tyres = Tyre.all
    # all_tyre = Tyre.all.where(status: "in used")
    # len = all_tyre.length
    # for i in 0..len-1
    #   @tyre_distance = Tyre.find(all_tyre[i].id)
    #   current_vehicle_distance = Vehicle.find(all_tyre[i].vehicle_id).distance
    #   new_tyre_distance = current_vehicle_distance - all_tyre[i].start_distance
    #   total_distance = all_tyre[i].total_distance
    #   @tyre_distance.update_attribute(:total_distance, new_tyre_distance + total_distance)
    # end
  end

  # GET /tyres/1
  # GET /tyres/1.json
  def show
  end

  #attach tyre to vehicle
  def attach
    @tyre = Tyre.find(params[:tyre_id])
    @tyre.update_attribute(:vehicle_id, params[:vehicle_id])
    @tyre.update_attribute(:start_distance, Vehicle.find(params[:vehicle_id]).distance)
    @tyre.update_attribute(:position, params[:position])
    @tyre.update_attribute(:status, "in used")
    @history = History.new(category: "tyre",
                           vehicle: @tyre.vehicle_id,
                           before_value: "available",
                           after_value: "in used",
                           email: params[:email],
                           attribute_name: "change status")
    @history.save
  end

  def dettach
    @tyre = Tyre.find(params[:tyre_id])
    @history = History.new(category: "tyre",
                           vehicle: @tyre.vehicle_id,
                           before_value: "in used",
                           after_value: "available",
                           email: params[:email],
                           attribute_name: "change status")
    if @history.save
      @tyre.update_attribute(:vehicle_id, "")
      @tyre.update_attribute(:position, "")
      @tyre.update_attribute(:status, "available")
    end
  end

  def destroyed
    @tyre = Tyre.find(params[:tyre_id])
    @history = History.new(category: "tyre",
                           vehicle: @tyre.vehicle_id,
                           before_value: "in used",
                           after_value: "destroyed",
                           email: params[:email],
                           attribute_name: "change status")
    if @history.save
      @tyre.update_attribute(:vehicle_id, "")
      @tyre.update_attribute(:position, "")
      @tyre.update_attribute(:status, "destroyed")
    end
  end

  #get all tyre position and display
  def current
    all_tyre_positions = Tyre.where(vehicle_id: params[:current_vehicle_id]).pluck(:position)
    respond_to do |format|
      format.html
      format.json { render json: all_tyre_positions }
    end
  end


  # GET /tyres/new
  def new
    @tyre = Tyre.new
  end

  # GET /tyres/1/edit
  def edit
  end

  # POST /tyres
  # POST /tyres.json
  def create
    @tyre = Tyre.new(tyre_params)

    respond_to do |format|
      if @tyre.save
        format.html { redirect_to @tyre, notice: 'Tyre was successfully created.' }
        format.json { render :show, status: :created, location: @tyre }
      else
        format.html { render :new }
        format.json { render json: @tyre.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tyres/1
  # PATCH/PUT /tyres/1.json
  def update
    respond_to do |format|
      if @tyre.update(tyre_params)
        format.html { redirect_to @tyre, notice: 'Tyre was successfully updated.' }
        format.json { render :show, status: :ok, location: @tyre }
      else
        format.html { render :edit }
        format.json { render json: @tyre.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tyres/1
  # DELETE /tyres/1.json
  def destroy
    @tyre.destroy
    respond_to do |format|
      format.html { redirect_to tyres_url, notice: 'Tyre was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tyre
      @tyre = Tyre.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tyre_params
      params.require(:tyre).permit(:brand, :serial, :start_distance, :total_distance, :status, :vehicle_id, :position)
    end
end
