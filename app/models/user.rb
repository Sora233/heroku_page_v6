class User < ApplicationRecord
  rolify strict: true

  scope :disabled, -> { where(disabled: true) }

  include UsersHelper

  has_and_belongs_to_many :block_users, -> { distinct },
                          class_name: "User",
                          join_table: "users_blockship",
                          association_foreign_key: "block_user_id"

  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :confirmable, :rememberable,
         :validatable, :lockable, :trackable

  include ActiveModel::Validations

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password, if: :password_required? # recommended
  validates_confirmation_of :password, if: :password_required? # recommended
  validates_length_of :password, within: password_length, allow_blank: true # recommended

  after_create :assign_default_role

  def assign_default_role
    add_role(:user) if roles.blank?
  end

  def disabled!
    unless disabled
      self.disabled = true
      save(validate: false)
    end
  end

  def enabled!
    if disabled
      self.disabled = false
      save(validate: false)
    end
  end

  def disabled?
    disabled
  end

  def enabled?
    !disabled
  end

  def inactive_message
    enabled? ? super : :blocked
  end

  def active_for_authentication?
    super && enabled?
  end

  def send_devise_notification(notification, *args)
    message = devise_mailer.send(notification, self, *args)
    if message.respond_to?(:deliver_later)
      message.deliver_later
    elsif message.respond_to?(:deliver_now)
      message.deliver_now
    else
      message.deliver
    end
  end

  def perform_lock?
    enabled?
  end

  def add_block_user(user)
    unless block_users.include?(user) || user == self
      block_users.append user
      true
    end
    false
  end

  def cancel_block_user(user)
    if block_users.include?(user) && user != self
      block_users.delete user
    end
  end

  def blocked_by
    User.joins(:block_users).where("block_user_id = ?", id).distinct
  end

end
