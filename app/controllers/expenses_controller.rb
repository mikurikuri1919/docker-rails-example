class ExpensesController < ApplicationController
  before_action :set_group_and_users, only: [:show, :edit, :update]
  before_action :set_expense, only: [:edit, :update]

  def show
    @difference = Expense.new.split_expenses(@users)
  end

  def edit
  end

  def update
    @users.each do |user|
      expense = user.expense
      amount = params["group"]["group_user_#{user.id}_expenses"].to_i
      if expense
        expense.update(amount: amount)
      else
        Expense.create(user_id: user.id, group_id: @group.id, amount: amount)
      end
    end

    redirect_to group_expense_path(@group)
  end

  private

  def set_group_and_users
    @group = Group.find(params[:group_id])
    @users = @group.users
  end

  def set_expense
    @expense = @group.expenses.find_by(user_id: @users.pluck(:id))
  end

  def expense_params
    params.require(:expense).permit(:amount, :group_id, :user_id)
  end
end
