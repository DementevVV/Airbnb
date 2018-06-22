class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]
  before_action :authorized_user, only: [:edit, :update, :destroy]

  def index
    @rooms = current_user.rooms
  end

  def show
    @photos = @room.photos
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)

    if @room.save
      if params[:images]
        params[:images].each do |image|
          @room.photos.create(image: image)
        end
      end
      
      @photos = @room.photos
      redirect_to edit_room_path(@room), notice: "Saved"
    else
      render :new
    end
  end

  def edit
    @photos = @room.photos
  end

  def update
    if @room.update(room_params)
      if params[:images]
        params[:images].each do |image|
          @room.photos.create(image: image)
        end
      end

      redirect_to edit_room_path(@room), notice: "Updated"
    else
      render :edit
    end
  end

  private
  def authorized_user
    @room = current_user.rooms.find_by(params[:id])
    redirect_to rooms_path, notice: "You don't have permission" if @room.nil?
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:home_type, :room_type, :accommodate,
      :bed_room, :bath_room, :listing_name, :summary, :address, :is_tv,
      :is_internet, :is_kitchen, :is_air, :is_heating, :price, :active)
  end
end
