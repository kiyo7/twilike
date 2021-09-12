class MicropostsController < ApplicationController

  before_action :logged_in_user?, only: [:create, :destroy]
  before_action :correct_user, only: :destroy


  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "投稿を作成しました"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render "static_pages/home"
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to request.referrer || root_url #referrerは1つ前のURLを返す(今回の場合はHomeページ)
    # redirect_back(fallback_location: root_url) # <-こちらでも同様に動く
  end

  #################################################################

  private

  #################################################################

  def micropost_params
    params.require(:micropost).permit(:content)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id]) #現在のユーザーが削除対象の投稿を保有しているかの確認
    redirect_to root_url if @micropost.nil?
  end
end
