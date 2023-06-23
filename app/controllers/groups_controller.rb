class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @group.update(group_params)
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
end
