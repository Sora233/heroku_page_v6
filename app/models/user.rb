class User < ApplicationRecord
  rolify strict: true

  scope :disabled, -> { where(disabled: false) }

  include ActiveModel::Validations

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: [:create, :update]
  validates :password_confirmation, presence: true, on: [:create, :update]

  include UsersHelper

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_and_belongs_to_many :users, :join_table => :users_roles
  has_many :posts

  devise :database_authenticatable, :registerable,
         :recoverable, :confirmable, :rememberable,
         :validatable, :lockable, :trackable

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

end
