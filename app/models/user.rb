# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string           default(""), not null
#  admin                  :boolean          default(FALSE), not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  has_many :tickets

  validates :name, presence: true #この行を追加しました(2019/1/22)

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  before_destroy :validate_ticket_presence

  private

  def validate_ticket_presence
    return true if tickets.blank?

    errors.add :base, 'このレコードを用いてチケットの申込が実施されています。削除する場合は申込済のチケットの情報を変更してください。'
    throw(:abort)
  end
end
