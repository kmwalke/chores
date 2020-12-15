class InstantiateTasksWorker
  include Sidekiq::Worker

  def perform(user_id)
    User.find(user_id).instantiate_tasks
  end
end
