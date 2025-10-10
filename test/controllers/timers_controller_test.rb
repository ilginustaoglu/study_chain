require "test_helper"

class TimersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @timer = timers(:one)
  end

  test "should get index" do
    get timers_url
    assert_response :success
  end

  test "should get new" do
    get new_timer_url
    assert_response :success
  end

  test "should create timer" do
    assert_difference('Timer.count') do
      post timers_url, params: { timer: { name: "New Timer", seconds: 0 } }
    end

    assert_redirected_to timers_path
  end

  test "should show timer" do
    get timer_url(@timer)
    assert_response :success
  end

  test "should get edit" do
    get edit_timer_url(@timer)
    assert_response :success
  end

  test "should update timer" do
    patch timer_url(@timer), params: { timer: { name: "Updated Timer" } }
    assert_redirected_to timers_path
  end

  test "should destroy timer" do
    assert_difference('Timer.count', -1) do
      delete timer_url(@timer)
    end

    assert_redirected_to timers_path
  end

  test "should start timer" do
    patch start_timer_url(@timer)
    assert_response :success
    @timer.reload
    assert @timer.is_running
  end

  test "should pause timer" do
    @timer.update(is_running: true)
    patch pause_timer_url(@timer)
    assert_response :success
    @timer.reload
    assert_not @timer.is_running
  end

  test "should reset timer" do
    @timer.update(seconds: 100, is_running: true)
    patch reset_timer_url(@timer)
    assert_response :success
    @timer.reload
    assert_equal 0, @timer.seconds
    assert_not @timer.is_running
  end

  test "should tick timer" do
    @timer.update(seconds: 10, is_running: true)
    patch tick_timer_url(@timer)
    assert_response :success
    @timer.reload
    assert_equal 11, @timer.seconds
  end

  test "should not tick paused timer" do
    @timer.update(seconds: 10, is_running: false)
    patch tick_timer_url(@timer)
    assert_response :success
    @timer.reload
    assert_equal 10, @timer.seconds
  end
end
