class UsersController < ApplicationController

  def index
    @q = User.search(params[:q])
    @users = @q.result(distinct: true).order("company is null ASC, company ASC", "name ASC").paginate(:page => params[:page], :per_page => 10)
  end

  private
    def user_params
      params.require(:user).permit(:name, :company, :description, :url)
    end
end
