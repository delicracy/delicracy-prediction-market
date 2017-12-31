require "application_system_test_case"

class RacesTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
  end

  test 'create and start a new race' do
    # Login and visit index page
    log_in_as @user
    visit races_url
    assert_selector 'h1', text: 'Races'

    # Submit the form
    click_on 'New Race'
    assert_selector 'h1', text: 'New Race'
    title = 'sample race'
    fill_in 'Title', with: title
    fill_in 'Description', with: 'sample race description'
    click_on 'Create Race'

    # Creates lanes
    assert_selector 'h4', text: title
    assert_text 'Lanes'

    number_of_lanes = 4
    number_of_lanes.times do |n|
      click_on 'New Lane'
      assert_button 'Create Lane'
      fill_in 'Title', with: "lane #{n}"
      fill_in 'Description', with: "lane #{n} descriptions."
      click_button 'Create Lane'
      assert_no_button 'Create Lane'
    end
    
    within '#lanes_list' do
      assert_selector '.list-group-item-heading', count: number_of_lanes
      assert_selector '.list-group-item-text', count: number_of_lanes
      assert_link 'New Lane'
    end

    # Start race
    assert_link 'Start!'
    click_on 'Start!'
    assert_no_link 'Start!'
    
    assert_no_link 'New Lane'
    within '#lanes_list' do
      assert_text 'lot', count: number_of_lanes
      assert_text 'price', count: number_of_lanes
      assert_text 'volume', count: number_of_lanes
    end
  end
end
