class InstantiateTasksWorker
  include Sidekiq::Worker

  def perform(user_id)
    User.find(user_id).build_task_list
  end
end
