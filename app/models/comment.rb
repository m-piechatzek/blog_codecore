class Comment < ActiveRecord::Base
  belongs_to :post
  # just added:
  belongs_to :user


end
