class ImportProductJob < ApplicationJob
  queue_as :default

  def self.perform file_path, project_id, user
    ps = ProductService.new(file_path, project_id, user).import
    #ActionCable.server.broadcast "import_notification_channel_#{user.id}", {message: ps[:message]}
  end
end
