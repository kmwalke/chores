class PermissionsController < ApplicationController
  before_action :set_permission, only: [:show, :edit, :update, :destroy]

  def index
    @permissions = Permission.all
  end

  def show; end

  def new
    @permission = Permission.new
  end

  def edit; end

  def create
    @permission = Permission.new(permission_params)

    respond_to do |format|
      if @permission.save
        format.html { redirect_to permissions_path, notice: 'Permission was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @permission.update(permission_params)
        format.html { redirect_to permissions_path, notice: 'Permission was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @permission.destroy
    respond_to do |format|
      format.html { redirect_to permissions_path, notice: 'Permission was successfully destroyed.' }
    end
  end

  private

  def set_permission
    @permission = Permission.find(params[:id])
  end

  def permission_params
    params.require(:permission).permit(:name, :description, :feature_id, action_ids: [])
  end
end
