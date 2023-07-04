class ExpensesController < ApplicationController
  def show
    @group = Group.find(params[:group_id])
    @users = @group.users
    @difference = Expense.new.split_expenses(@users)
  end

  def edit
    @group = Group.find(params[:group_id])
    @users = @group.users
  end

  def update
    @group = Group.find(params[:group_id])
    @users = @group.users

    @users.each do |user|
      expense = user.expense
      amount = params["group_user_#{user.id}_expenses"].to_i
      expense.update(amount: amount) if expense
    end

    redirect_to expense_path(@group)
  end

  private

  def expense_params
    params.require(:expense).permit(:amount, :group_id, :user_id)
  end
end
