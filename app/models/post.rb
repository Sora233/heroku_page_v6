class Post < ApplicationRecord
  include PostsHelper
  belongs_to :user

  include ActiveModel::Validations

  scope :opened, -> { where(public: true, published: true) }
  scope :draft, -> { where(public: true, published: false) }

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

end
