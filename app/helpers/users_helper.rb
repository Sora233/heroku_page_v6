module UsersHelper
  USER_ROLE = %i(admin user).freeze

  USER_ROLE.each do |role|
    define_method "#{role}!" do
      self.roles.reload
      self.roles.each do |self_role|
        self.remove_role self_role
      end
      self.add_role role
    end

    define_method "#{role}?" do
      self.has_cached_role? role
    end

    define_method "require_#{role}!" do
      raise CanCan::AccessDenied.new("Not authorized!", "require", role, "has_role?") unless self.has_cached_role? role
    end
  end

  def role
    USER_ROLE.each do |role|
      return role if self.send "#{role}?"
    end
    :user
  end

end
