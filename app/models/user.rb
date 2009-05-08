# == Schema Information
# Schema version: 20090506170628
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(100)     default("")
#  email              :string(100)
#  salt               :string(40)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(128)
#  token              :string(128)
#  token_expires_at   :datetime
#  email_confirmed    :boolean         not null
#
class User < ActiveRecord::Base
  include Clearance::User

  attr_accessible :name
  
  has_many :data_files
  has_many :components

end
