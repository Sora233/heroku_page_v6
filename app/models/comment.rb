class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_one :self_ref, :class_name => "Comment", :foreign_key => :id
  has_one :post, :through => :self_ref, :source => :commentable, :source_type => "Post"

  scope :natural_order, -> { order(created_at: :desc) }

  after_create_commit do
    CommentDeliverJob.perform_later self, self.user
  end

  has_rich_text :content

  include ActiveModel::Validations

  validates :content, presence: true

  def username
    self&.user&.username || t("user.canceled_name")
  end

end
