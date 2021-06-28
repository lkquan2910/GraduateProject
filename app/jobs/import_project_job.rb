class ImportProjectJob < ApplicationJob
  queue_as :default

  def self.perform file_path, user
    ps = ProjectService.new(file_path, user).import
    ActionCable.server.broadcast "import_notification_channel_#{user.id}", {message: ps[:message]}
  end
end
