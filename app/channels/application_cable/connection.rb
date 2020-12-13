module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user, :uuid

    def connect
      user = find_verified_user
      if user
        self.current_user = user.username
        identify = self.current_user
      else
        self.uuid = SecureRandom.urlsafe_base64
        identify = self.uuid
      end
      logger.add_tags 'ActionCable', identify
    end

    protected

    def find_verified_user
      env['warden'].user rescue nil
    end

  end
end
