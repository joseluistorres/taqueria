class TacosController < ApplicationController
  before_action :set_taco, only: [:show, :edit, :update, :destroy]

  # GET /tacos
  # GET /tacos.json
  def index
    @tacos = Taco.all

    if filterer_params
       @tacos = @tacos.for_name(filterer_params[:name]) if filterer_params[:name].present?
       @tacos = @tacos.for_spicy(filterer_params[:spicy]) if filterer_params[:spicy].present? && Taco::SPICYNESS.include?(filterer_params[:spicy])
       @tacos = @tacos.for_meat(filterer_params[:meat]) if filterer_params[:meat].present? && Taco::MEATS.include?(filterer_params[:meat])
    end
  end

  # GET /tacos/1
  # GET /tacos/1.json
  def show
  end

  # GET /tacos/new
  def new
    @taco = Taco.new
  end

  # GET /tacos/1/edit
  def edit
  end

  # POST /tacos
  # POST /tacos.json
  def create
    @taco = Taco.new(taco_params)

    respond_to do |format|
      if @taco.save
        format.html { redirect_to tacos_path, notice: 'Taco was successfully created.' }
        format.json { render :show, status: :created, location: @taco }
      else
        format.html { render :new }
        format.json { render json: @taco.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tacos/1
  # PATCH/PUT /tacos/1.json
  def update
    respond_to do |format|
      if @taco.update(taco_params)
        format.html { redirect_to @taco, notice: 'Taco was successfully updated.' }
        format.json { render :show, status: :ok, location: @taco }
      else
        format.html { render :edit }
        format.json { render json: @taco.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tacos/1
  # DELETE /tacos/1.json
  def destroy
    @taco.destroy
    respond_to do |format|
      format.html { redirect_to tacos_url, notice: 'Taco was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_taco
      @taco = Taco.find(params[:id])
    end

    def filterer_params
      unless params.key?(:filter)
        return
      end

      params.require(:filter).permit(:name, :spicy, :meat)
    end

    def taco_params
      params.require(:taco).permit(:name, :spicy, :double_tortilla, :meat)
    end
end
