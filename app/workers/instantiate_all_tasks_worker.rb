class InstantiateAllTasksWorker
  include Sidekiq::Worker

  def perform
    User.find_each do |user|
      InstantiateTasksWorker.perform_async(user.id)
    end
  end
end
