class FeaturesController < ApplicationController
  before_action :set_feature, only: [:show, :edit, :update, :destroy]

  def index
    @features = Feature.order(:name)
  end

  def show; end

  def new
    @feature = Feature.new
  end

  def edit; end

  def create
    @feature = Feature.new(feature_params)

    respond_to do |format|
      if @feature.save
        format.html { redirect_to features_path, notice: 'Feature was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @feature.update(feature_params)
        format.html { redirect_to features_path, notice: 'Feature was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @feature.destroy
    respond_to do |format|
      format.html { redirect_to features_path, notice: 'Feature was successfully destroyed.' }
    end
  end

  private

  def set_feature
    @feature = Feature.find(params[:id])
  end

  def feature_params
    params.expect(feature: [:name])
  end
end
