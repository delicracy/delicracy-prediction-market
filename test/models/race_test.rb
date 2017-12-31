require 'test_helper'

class RaceTest < ActiveSupport::TestCase
  def setup
    @race = build(:race)
    @user = create(:user)
  end

  test "should be valid" do
    assert @race.valid?
  end

  test "title should be present" do
    @race.title = '     '
    assert_not @race.valid?
  end

  test "prepare racing" do
    @race.save
    4.times do |i|
      @race.lanes << create(:lane)
    end
    @race.prepare! 
    @race.lanes.each do |lane|
      lane.reload
      assert_equal MY_APP[:initial_lot_per_lane], lane.lot, "#{@race.inspect}"
      assert lane.price
      assert lane.volume
      assert_equal lane.lot * lane.price, lane.volume
    end
  end

  test "should set initial_lot before create" do
    race = build(:race)
    race.save
    assert_equal MY_APP[:initial_lot_per_lane], race.initial_lot
  end

  test "should not offer lots before race prepared" do
    
  end

  test "payoff by Winner Takes All" do
    @race = build(:race, rule: Race::WINNER_TAKES_ALL)
    @race.payoff
  end

  test "payoff by Vote Share" do
    @race = build(:race, rule: Race::VOTE_SHARE)
    @race.payoff
  end

  test "should participate user when user is assigned to host" do
    @race.save
    @race.assign_to :host, @user
    assert_includes @race.participants, @race.host
  end
end
