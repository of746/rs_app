class ReservationsController < ApplicationController
  before_action :authenticate_user!

    def confirm
      @reservation = current_user.reservations.new(reservation_params)
      @room = @reservation.room

      if @reservation.valid?
      else
        flash[:alert] = "入力内容に誤りがあります"
        render "rooms/show", status: :unprocessable_entity
      end
    end

    def confirm_update
        @reservation = Reservation.find(params[:id])
        @reservation.assign_attributes(reservation_params)
        @room = @reservation.room

        if @reservation.valid?
          render :confirm_update
        else
          render :edit
        end
    end

    def create
      @reservation = current_user.reservations.new(reservation_params)

      if @reservation.save
        redirect_to reservations_path, notice: "予約が完了しました"
      else
        render :confirm
      end
    end

    def index
      @reservations = current_user.reservations.includes(:room).order(created_at: :desc)
    end

    def edit
      @reservation = Reservation.find(params[:id])
      @room = @reservation.room
    end

    def update
      @reservation = Reservation.find(params[:id])
      if @reservation.update(reservation_params)
        redirect_to :reservations, notice: "予約を更新しました"
      else
        render "edit"
      end
    end

    def destroy
      @reservation = current_user.reservations.find(params[:id])
      @reservation.destroy
      redirect_to reservations_path, notice: "予約を削除しました"
    end

    private

    def reservation_params
      params.require(:reservation).permit(:room_id, :checkin_date, :checkout_date, :number_of_people)
    end
  end

