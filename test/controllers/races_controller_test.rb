require 'test_helper'

class RacesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @race = create(:race)
    @user = create(:user)
    log_in_as @user
    # @user = User.create(email: 'foobar@example.com', password: 'password', password_confirmation: 'password')
  end

  test "should get index" do
    get races_url
    assert_response :success
  end

  test "should redirect get new when not logged in" do
    get new_race_url
    assert_redirected_to login_url
  end

  test "should get new when logged in" do
    log_in_as @user
    get new_race_url
    assert_response :success
  end

  test "should redirect create race when not logged in" do
    assert_no_difference('Race.count') do
      post races_url, params: { race: { description: @race.description, title: @race.title } }
    end
    assert_redirected_to login_url
  end

  test "should create race when logged in" do
    assert_difference('Race.count') do
      post races_url, params: { race: attributes_for(:race)}
    end
    assert_redirected_to race_url(Race.last)
  end

  test "should show race" do
    get race_url(@race)
    assert_response :success
  end

  test "should get edit" do
    # log_in_as @user
    # post login_url, session: { user_id: @user.id }
    session[:user_id] = @user.id
    get edit_race_url(@race)
    assert_response :success
  end

  test "should update race" do
    log_in_as @user
    patch race_url(@race), params: { race: { description: @race.description, title: @race.title } }
    assert_redirected_to race_url(@race)
  end

  test "should destroy race" do
    log_in_as @user
    assert_difference('Race.count', -1) do
      delete race_url(@race)
    end

    assert_redirected_to races_url
  end
end
