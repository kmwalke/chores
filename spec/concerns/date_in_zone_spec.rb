require 'rails_helper'

describe DateInZone do
  let(:test_class) { Struct.new(:name) { include DateInZone } }
  let(:test_instance) { test_class.new(name: 'thing') }

  it 'gets today for utc' do
    expect(test_instance.today_in_zone('UTC')).to eq(Date.today)
  end

  it 'gets today for mst' do
    expect(test_instance.today_in_zone('MST')).to eq(Time.find_zone!('MST').today)
  end

  it 'gets yesterday for utc' do
    expect(test_instance.yesterday_in_zone('UTC')).to eq(Date.yesterday)
  end

  it 'gets yesterday for mst' do
    expect(test_instance.yesterday_in_zone('MST')).to eq(Time.find_zone!('MST').yesterday)
  end
end
