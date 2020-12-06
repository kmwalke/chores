require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should require a name' do
    expect(User.create(name: '').errors).to have_key(:name)
  end

  it 'should require an email' do
    expect(User.create(email: '').errors).to have_key(:email)
  end

  it 'should require email uniqueness' do
    User.create(email: 'email', name: 'name', password: '123')
    expect(User.create(email: 'email').errors).to have_key(:email)
  end

  it 'should require a role' do
    expect(User.create(role: nil).errors).to have_key(:role)
  end

  describe 'leveling' do
    let!(:role) { Role.create(name: 'role1') }
    let(:user) { User.create(email: 'email@domain.com', name: 'name', role: role, password: '123') }

    it 'should start at level 1' do
      expect(user.level).to eq(1)
    end

    it 'should start at xp_multiplier 1' do
      expect(user.xp_multiplier).to eq(1)
    end

    it 'should start at xp 0' do
      expect(user.xp).to eq(0)
    end

    it 'should receive xp' do
      user.add_xp(10)
      expect(user.xp).to eq(10)
    end

    it 'should use the xp multiplier' do
      user.xp_multiplier = 1.3
      user.add_xp(10)
      expect(user.xp).to eq(13)
    end

    it 'cannot set xp_multiplier less than 1' do
      user.xp_multiplier = 0
      expect(user.save).to eq(false)
    end

    it 'should level up' do
      user.add_xp(User::XP_PER_LEVEL+1)
      expect(user.level).to eq(2)
    end

    it 'should get progress to next level' do
      user.add_xp(User::XP_PER_LEVEL * 1.75)
      expect(user.progress_to_level).to eq(0.75)
    end
  end
end
