class PicturesController < ApplicationController

  # ログインしていない時は投稿できないようにする
  before_action :authenticate_user!, only: :new

  # リクエストパラメータで指定されたページ番号 ( params[:page] ) を指定する
  def index
    @pictures = Picture.page(params[:page]).per(100).order("created_at DESC")
  end

  def men
    @men = Picture.page(params[:page]).per(100).where(gender: 1).order('created_at DESC')
  end

  def women
    @women = Picture.page(params[:page]).per(100).where(gender: 2).order('created_at DESC')
  end

  def show
    @picture = Picture.find(params[:id])
    @user = current_user
  end

  def new
    @picture = Picture.new
  end

  def create
    Picture.create(picture_params)
    redirect_to controller: :pictures, action: :index
  end

  private
  def picture_params
    params.require(:picture).permit(:image, :comment)
  end

end
