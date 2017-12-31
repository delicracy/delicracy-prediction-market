require 'test_helper'

class OperatorTest < ActiveSupport::TestCase
  setup do
    @michael = build_stubbed(:michael)
    @john = build_stubbed(:john)
    @operator = create(:operator)
  end

  test "should be valid" do
    assert @operator.valid?
  end

  test "should require a race_id" do
    @operator.race_id = nil
    assert_not @operator.valid?
  end

  test "should require a host_id" do
    @operator.host_id = nil
    assert_not @operator.valid?
  end

  test "should not be required a oracle_id" do
    @operator.oracle_id = nil
    assert @operator.valid?
  end

  test "should know host and oracle each other" do
    skip
    race = @operator.race
    assert_equal @michael, race.host
    assert_equal @john, race.oracle
    # HACK: assert_not race.save를 해놓고 한참 헤멨다! 더 편하고 안전하게 구현해.
    race.oracle = race.host
    assert_not race.supporting_operator.save
  end
end
