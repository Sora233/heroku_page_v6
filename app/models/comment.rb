class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_rich_text :content

  include ActiveModel::Validations

  validates :content, presence: true

  def username
    self&.user&.username || "User Canceled"
  end

end
