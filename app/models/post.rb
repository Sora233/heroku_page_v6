class Post < ApplicationRecord
  include PostsHelper
  belongs_to :user

  has_many :comments, as: :commentable, dependent: :destroy

  has_rich_text :content

  scope :opened, -> { where(published: true) }
  scope :draft, -> { where(published: false) }
  scope :natural_order, -> { order(updated_at: :desc, created_at: :desc) }

  include ActiveModel::Validations
  validates :title, presence: true
  validates :content, presence: true

  def published=(value)
    super(ActiveModel::Type::Boolean.new.cast(value))
  end

  def do_visit
    Post.increment_counter(:visit_count, self.id)
  end

  def username
    self&.user&.username || t("user.canceled_name")
  end

end
