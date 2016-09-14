require 'securerandom'

class Token < ApplicationRecord

  before_create :set_token

  has_one :organisation, :through => :organisations_tokens, :class_name => 'Organisation'

  has_and_belongs_to_many :datasets

  def self.authenticate(token)
    find_by(:token => token.to_s)
  end

  def to_s
    token
  end

  private

  def set_token
    self.token = generate_token if self.token.blank?
  end

  def generate_token
    2.times.collect{ SecureRandom.uuid.gsub(/\-/,'') }.join
  end

end
