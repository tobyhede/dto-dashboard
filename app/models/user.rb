class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable
  devise :database_authenticatable, :confirmable, :lockable, :recoverable, :rememberable, :timeoutable, :trackable, :validatable
end
