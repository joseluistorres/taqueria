class TacosController < ApplicationController
  before_action :set_taco, only: [:show, :edit, :update, :destroy]

  # GET /tacos
  # GET /tacos.json
  def index
    base_arel = Taco.all

    filterer = Tacos::Filterer.new(
            filterer_params,
            base_arel: base_arel)
    @tacos = filterer.tacos

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
      params.require(:taco).permit(Tacos::Filterer::FILTER_ATTRIBUTES)
    end
end
