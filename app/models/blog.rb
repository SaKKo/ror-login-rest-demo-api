# == Schema Information
#
# Table name: blogs
#
#  id         :bigint           not null, primary key
#  body       :text
#  title      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Blog < ApplicationRecord
end
