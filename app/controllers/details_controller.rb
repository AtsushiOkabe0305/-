class DetailsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @details = Detail.all
  end

  def show
    @detail = Detail.find(params[:id])
  end

  def new
    @detail = Detail.new
  end
  
  def create
    @detail = Detail.new(detail_params)
    @detail.user_id = current_user.id
    if @detail.save
     redirect_to detail_path(@detail), notice: '投稿に成功しました'
    else
     render :new
    end
  end
  
  def edit
    @detail = Detail.find(params[:id])
    if @detail.user != current_user
      redirect_to details_path, alert:'不正なアクセスです'
    end
  end
  
  def update
    @detail = Detail.find(params[:id])
    if @detail.update(detail_params)
      redirect_to detail_path(@detail), notice: '更新に成功しました'
    else
      render :edit
    end
  end
  
  private
  def detail_params
    params.require(:detail).permit(:title, :body, :image)
  end
  
end
