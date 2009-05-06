# == Schema Information
# Schema version: 20090310125016
#
# Table name: data_files
#
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  description          :string(255)
#  content_file_name    :string(255)
#  content_content_type :string(255)
#  content_file_size    :integer
#  user_id              :integer
#  created_at           :datetime
#  updated_at           :datetime
#

class DataFile < ActiveRecord::Base
  has_attached_file :content, :path => ":rails_root/public/system/data/:id/:basename.:extension"
  belongs_to :user
end
