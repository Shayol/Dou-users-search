class UsersController < ApplicationController

  def index
    @q = User.search(params[:q])
    @users = @q.result(distinct: true)
  end
end
