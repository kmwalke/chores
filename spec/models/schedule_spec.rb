require 'rails_helper'

RSpec.describe Schedule, type: :model do
  it 'should require a model' do
    expect { FactoryBot.create(:schedule, model: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should require occurrences or due_date' do
    expect do
      FactoryBot.create(:schedule, occurrences: nil, due_date: nil).errors
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
end
