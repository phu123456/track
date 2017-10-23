class TyresController < ApplicationController
  before_action :set_tyre, only: [:show, :edit, :update, :destroy]

  # GET /tyres
  # GET /tyres.json
  def index
    @tyres = Tyre.all
  end

  # GET /tyres/1
  # GET /tyres/1.json
  def show
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
      params.require(:tyre).permit(:brand, :serial, :start_distance, :total_distance, :status, :truck_id)
    end
end
