class User < ApplicationRecord
  devise :database_authenticatable, :confirmable, :lockable, :recoverable, :rememberable, :timeoutable, :trackable, :validatable

  has_many :tokens

  has_and_belongs_to_many :dashboards

  has_many :datasets, :through => :dashboards

  scope :by_email, -> { order(:email => 'ASC') }

  def self.authenticate!(token)
    Token.authenticate!(token).user
  end

  def token
    tokens.active.first
  end

  def to_s
    email
  end
end
