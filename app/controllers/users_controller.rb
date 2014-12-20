class UsersController < ApplicationController

  def index
    @q = User.search(params[:q])
    @users = @q.result(distinct: true)
  end

  private
    def user_params
      params.require(:user).permit(:name, :description, :url)
    end
end
