class LaunchesController < ApplicationController
  def show
    @launche = Launche.find(params[:id])
  end

  def new
    @launche = Launche.new
  end

  def create
    @launche = Launche.new(params[:launche])
    if @launche.save
      flash[:success] = "Launche was successfully created.."
      redirect_to @launche 
    else
      render 'new'
    end
  end
end
