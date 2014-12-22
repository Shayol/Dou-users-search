class UsersController < ApplicationController

  def index
    @q = User.search(params[:q])
    @users = @q.result(distinct: true).paginate(:page => params[:page], :per_page => 10)
    @database = @users.count
  end

  private
    def user_params
      params.require(:user).permit(:name, :company, :description, :url)
    end
end
