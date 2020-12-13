class Post < ApplicationRecord
  include PostsHelper
  belongs_to :user

  has_rich_text :content

  include ActiveModel::Validations

  scope :opened, -> { where(published: true) }
  scope :draft, -> { where(published: false) }

  scope :natual_order, -> { order(updated_at: :desc, created_at: :desc) }

  has_many :comments, as: :commentable, dependent: :destroy

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
