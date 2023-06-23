class Group < ApplicationRecord
  with_options presence: true do
    validates :name
  end
end
