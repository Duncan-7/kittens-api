class KittensController < ApplicationController
  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html
      format.json { render :json => @kittens }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @kitten }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(assign_params)
    if @kitten.save
      flash[:info] = "Another adorable kitten added!"
      redirect_to root_path
    else
      flash.now[:alert] = "This isn't Game of Thrones, give your kitten a name!"
      render 'new'
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end
  
  def update
    @kitten = Kitten.find(params[:id])
    if @kitten.update_attributes(assign_params)
      flash[:info] = "Kitten updated!"
      redirect_to root_path
    else
      flash.now[:info] = "Try again dummy!"
      render 'edit'
    end
  end

  def destroy
    Kitten.find(params[:id]).destroy
    flash[:alert] = "You destroyed a kitten. You monster."
    redirect_to root_path
  end

  private
    def assign_params
      params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end
end
