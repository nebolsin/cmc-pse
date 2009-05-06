# == Schema Information
# Schema version: 20090309130349
#
# Table name: users
#
#  id                        :integer         not null, primary key
#  login                     :string(40)
#  name                      :string(100)     default("")
#  email                     :string(100)
#  crypted_password          :string(40)
#  salt                      :string(40)
#  created_at                :datetime
#  updated_at                :datetime
#  remember_token            :string(40)
#  remember_token_expires_at :datetime
#
class User < ActiveRecord::Base
  include Clearance::User

  has_many :data_files
end
