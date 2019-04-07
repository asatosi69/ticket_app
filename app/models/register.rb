class Register < ApplicationRecord
  belongs_to :user
  enum state: { init: 0, confirmed: 10 }
end
