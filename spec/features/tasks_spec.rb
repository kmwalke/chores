require 'rails_helper'

RSpec.feature 'Tasks', type: :feature do
  let(:admin) { create(:user, role: create(:role_admin)) }
  let!(:task) { create(:task, user: admin) }
  let(:user) { create(:user) }
  let!(:user_task) { create(:task, user: user) }

  before do
    login(admin)
  end

  scenario 'list my tasks' do
    visit tasks_path
    expect(page).to have_content(task.name)
  end

  scenario 'not list other\'s tasks' do
    visit tasks_path
    expect(page).to have_no_content(user_task.name)
  end

  scenario 'show a task' do
    visit task_path(task)
    expect(page).to have_content(task.name)
  end

  scenario 'not show another\'s task' do
    visit task_path(user_task)
    expect(page).to have_current_path(tasks_path, ignore_query: true)
  end

  scenario 'create a task' do
    task2 = build(:task)
    visit tasks_path

    click_link 'New Task'
    fill_in_form(task2)
    click_button 'Create Task'

    expect(page).to have_current_path(tasks_path, ignore_query: true)
    expect(page).to have_content(task2.name)
    expect(Task.find_by(name: task2.name).user).to eq(admin)
  end

  scenario 'edit a task' do
    visit tasks_path

    click_link task.name
    task.name = 'new name'
    fill_in_form(task)
    click_button 'Update Task'

    expect(page).to have_current_path(tasks_path, ignore_query: true)
    expect(page).to have_content(task.name)
  end

  scenario 'not edit another\'s task' do
    visit edit_task_path(user_task)
    expect(page).to have_current_path(tasks_path, ignore_query: true)
  end

  scenario 'delete a task' do
    task_id = task.id
    visit tasks_path

    click_link "delete_#{task.id}"
    expect(page).to have_current_path(tasks_path, ignore_query: true)
    expect(Task.find_by(id: task_id)).to be_nil
  end

  def fill_in_form(task)
    fill_in 'Name', with: task.name
    fill_in 'Frequency', with: task.frequency
    fill_in 'Size', with: task.size
  end
end
