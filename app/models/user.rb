class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do
    validates :name
  end
  has_many :group_members, dependent: :destroy
  has_many :groups, through: :group_members
  has_one :expense, dependent: :destroy
end
