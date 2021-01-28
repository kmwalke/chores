class RatingsController < ApplicationController
  def new
  @rating = Rating.new
  end
  def create
    @rating = Rating.new(ratings_params.merge(user_id: current_user.id)
    respond_to do |format|
      if @rating.save
        format.html { redirect_to ratings_path, notice: 'Thank you for your feed back!' }
      else
        format.html { render :new }
      end
    end
  end

private
 def rating_params
    params.require(:rating).permit(:happiness, :description)
  end

end
