class MaintenancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_maintenance, only: [:show, :edit, :update, :destroy, :reset]

  # GET /maintenances
  # GET /maintenances.json
  def index
    @maintenances = Maintenance.all
  end

  # GET /maintenances/1
  # GET /maintenances/1.json
  def show
  end

  def reset
    Maintenance.update(params[:id], :start_distance => Maintenance.find(params[:id]).current_distance, :manually_distance => 0)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: [Maintenance.percentage(params[:id]), Maintenance.getStatus(params[:id])] }
    end
  end

  # GET /maintenances/new
  def new
    @maintenance = Maintenance.new
  end

  # GET /maintenances/1/edit
  def edit
  end

  # POST /maintenances
  # POST /maintenances.json
  def create
    # @maintenance = Maintenance.new(maintenance_params)
    distance = Vehicle.find(maintenance_params[:vehicle_id]).distance
    manually_distance = 0
    if (maintenance_params[:manually_distance].blank?)
      manually_distance = 0
    else
      manually_distance = maintenance_params[:manually_distance]
    end
    @maintenance = Maintenance.new(service_id: maintenance_params[:service_id],
                                   start_distance: distance,
                                   current_distance: distance,
                                   manually_distance: manually_distance,
                                   vehicle_id: maintenance_params[:vehicle_id]
                                 )

    if Maintenance.where(vehicle_id: @maintenance.vehicle_id).where(service_id: @maintenance.service_id).empty?
      respond_to do |format|
        if @maintenance.save
          format.html { redirect_to @maintenance, notice: 'Maintenance was successfully created.' }
          format.json { render :show, status: :created, location: @maintenance }
        else
          format.html { render :new }
          format.json { render json: @maintenance.errors, status: :unprocessable_entity }
        end
      end
    else
      raise "no!"
    end
  end

  # PATCH/PUT /maintenances/1
  # PATCH/PUT /maintenances/1.json
  def update
    respond_to do |format|
      if @maintenance.update(maintenance_params)
        format.html { redirect_to @maintenance, notice: 'Maintenance was successfully updated.' }
        format.json { render :show, status: :ok, location: @maintenance }
      else
        format.html { render :edit }
        format.json { render json: @maintenance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintenances/1
  # DELETE /maintenances/1.json
  def destroy
    @maintenance.destroy
    respond_to do |format|
      format.html { redirect_to maintenances_url, notice: 'Maintenance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maintenance
      @maintenance = Maintenance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def maintenance_params
      params.require(:maintenance).permit(:service_id, :start_distance, :current_distance, :manually_distance, :vehicle_id)
    end
end
