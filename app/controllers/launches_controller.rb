class LaunchesController < ApplicationController
  
  def index
    @launches = Launche.all
  end

  def show
    @launche = Launche.find(params[:id])
  end

  def new
    @launche = Launche.new
  end

  def edit
    @launche = Launche.find(params[:id])
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

  def update
    @launche = Launche.find(params[:id])
    if @launche.update_attributes(params[:launche])
      flash[:success] = "Launche was successfully updated.."
      redirect_to @launche 
    else
      render 'edit'
    end
  end

end
