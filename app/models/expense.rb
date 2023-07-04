class Expense < ApplicationRecord
  belongs_to :user
  belongs_to :group

  def split_expenses(users)
    total_amount = users.sum { |user| user.expense&.amount.to_i }
    num_users = users.size
    per_person_amount = total_amount / num_users

    differences = users.map do |user|
      paid_amount = user.expense&.amount.to_i
      difference = per_person_amount - paid_amount
      { user: user, difference: difference }
    end

    return differences
  end
end
