class Post < ApplicationRecord
  include PostsHelper
  belongs_to :user

  include ActiveModel::Validations

  scope :opened, -> { where(published: true) }
  scope :draft, -> { where(published: false) }

  validates :title, presence: true

  # validate content
  validate do
    if content.blank?
      errors.add(:content, :blank)
    elsif !valid_json?(content)
      errors.add(:content, "Invalid Format, Please Report a Bug")
    end
  end

  def published=(value)
    super(ActiveModel::Type::Boolean.new.cast(value))
  end

  def do_visit
    Post.increment_counter(:visit_count, self.id)
  end

  def username
    self&.user&.username || "Canceled User"
  end

end
