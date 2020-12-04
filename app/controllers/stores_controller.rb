class StoresController < ApplicationController
  def show
    @store = User.find(params[:id])
  end
end
