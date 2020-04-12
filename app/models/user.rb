# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  auth_token             :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  first_name             :text
#  last_name              :text
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_auth_token            (auth_token)
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  before_validation :generate_auth_token, on: [:create]

  def generate_auth_token(force = false)
    if self.new_record?
      self.auth_token ||= SecureRandom.uuid
    else
      if self.auth_token.blank? || force
        self.update_columns(auth_token: SecureRandom.uuid)
      end
    end
  end

  def sign_in_json
    json = {
      id: self.id,
      first_name: self.first_name,
      last_name: self.last_name,
      email: self.email,
      auth_jwt: self.auth_jwt,
    }
    json
  end

  def auth_jwt(duration = 15.days.from_now.to_i)
    ApiJwt.encrypt_jwt({ auth_token: self.auth_token }, Rails.application.credentials.user_jwt_secret, duration)
  end
end
