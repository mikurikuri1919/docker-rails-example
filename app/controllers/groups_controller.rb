class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update]

  def index
    @groups = Group.all
    @user = User.find(current_user.id)
  end

  def new
    @group = Group.new
    @user_list = @group.users.pluck(:id).join(',')
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      user_list = user_params[:user_lists].delete(' ').split(',')

      @group.save_user(user_list)
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @user = User.find(current_user.id) if current_user
  end

  def edit
    @group = Group.find(params[:id])
    @user_list = @group.users.pluck(:name).join(',')
  end

  def update
    @group = Group.find(params[:id])
    @user_list = user_params[:user_lists].delete(' ')
    if @group.update(group_params)
      @group.save_user(@user_list.split(','))
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name)
  end

  def user_params
    params.require(:group).permit(:user_lists)
  end
end
