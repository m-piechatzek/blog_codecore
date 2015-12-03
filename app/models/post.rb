class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :user_comments, through: :user

  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

    validates :title, {presence:   true}

    has_many :tags, through: :taggings
    has_many :taggings, dependent: :destroy

  def like_for(user)
    likes.find_by_user_id(user)
  end
end
