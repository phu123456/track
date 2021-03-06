require 'test_helper'

class HistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @history = histories(:one)
  end

  test "should get index" do
    get histories_url
    assert_response :success
  end

  test "should get new" do
    get new_history_url
    assert_response :success
  end

  test "should create history" do
    assert_difference('History.count') do
<<<<<<< HEAD
      post histories_url, params: { history: { category: @history.category } }
=======
      post histories_url, params: { history: { after_value: @history.after_value, attribute_name: @history.attribute_name, before_value: @history.before_value, category: @history.category, email: @history.email, vehicle: @history.vehicle } }
>>>>>>> history
    end

    assert_redirected_to history_url(History.last)
  end

  test "should show history" do
    get history_url(@history)
    assert_response :success
  end

  test "should get edit" do
    get edit_history_url(@history)
    assert_response :success
  end

  test "should update history" do
<<<<<<< HEAD
    patch history_url(@history), params: { history: { category: @history.category } }
=======
    patch history_url(@history), params: { history: { after_value: @history.after_value, attribute_name: @history.attribute_name, before_value: @history.before_value, category: @history.category, email: @history.email, vehicle: @history.vehicle } }
>>>>>>> history
    assert_redirected_to history_url(@history)
  end

  test "should destroy history" do
    assert_difference('History.count', -1) do
      delete history_url(@history)
    end

    assert_redirected_to histories_url
  end
end
