class Group < ApplicationRecord
  with_options presence: true do
    validates :name
  end
  has_many :group_members, dependent: :destroy
  has_many :users, through: :group_members

  has_many :expenses, dependent: :destroy

  def save_user(sent_users)
    # 送られてきたユーザー名を元に、Userモデルからユーザーを検索し、存在するユーザーのみを抽出
    exist_new_users = sent_users.map do |sent_user|
      User.find_by(name: sent_user)
    end.compact

    current_users = users.pluck(:id)
    old_users = current_users - exist_new_users.map(&:id)
    new_users = exist_new_users - users

    # 古いユーザーを削除
    group_members.where(user_id: old_users).destroy_all

    # 新しいユーザーを追加
    users << new_users
  end
end
