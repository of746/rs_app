class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    @users = User.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(params.require(:room).permit(:facility_name, :facility_Introduction, :fee, :address, :facility_image, :user_id))
    if @room.save
      flash[:notice] = "施設を新規登録しました"
      redirect_to :rooms
    else
      render "new"
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(params.require(:room).permit(:facility_name, :facility_Introduction, :fee, :address, :facility_image))
      redirect_to :rooms, notice: "施設情報を更新しました"
    else
      render "edit"
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "施設を削除しました"
    redirect_to :rooms
  end

  def search
    @keyword = params[:keyword]
    @area = params[:area]

    @rooms = Room.all

    # エリア検索（住所に対するあいまい検索）
    if @area.present?
      @rooms = @rooms.where("address LIKE ?", "%#{@area}%")
    end

    # フリーワード検索（施設名 or 詳細 に対するあいまい検索）
    if @keyword.present?
      @rooms = @rooms.where(
        "facility_name LIKE :keyword OR facility_introduction LIKE :keyword",
        keyword: "%#{@keyword}%"
      )
    end

    # 検索結果の合計数
    @total_count = @rooms.count
  end
end
