require "test_helper"

class TimerTest < ActiveSupport::TestCase
  test "should not save timer without name" do
    timer = Timer.new
    assert_not timer.save, "Saved the timer without a name"
  end

  test "should save timer with name" do
    timer = Timer.new(name: "Study Timer")
    assert timer.save, "Could not save the timer with a name"
  end

  test "should have default seconds as 0" do
    timer = Timer.create(name: "Test Timer")
    assert_equal 0, timer.seconds, "Default seconds should be 0"
  end

  test "should have default is_running as false" do
    timer = Timer.create(name: "Test Timer")
    assert_equal false, timer.is_running, "Default is_running should be false"
  end

  test "formatted_time should return correct format" do
    timer = Timer.create(name: "Test Timer", seconds: 3661)
    assert_equal "01:01:01", timer.formatted_time
  end

  test "alarm_time should return correct format" do
    timer = Timer.create(name: "Test Timer", alarm_seconds: 3600)
    assert_equal "01:00", timer.alarm_time
  end

  test "alarm_time= should set alarm_seconds correctly" do
    timer = Timer.new(name: "Test Timer")
    timer.alarm_time = "02:30"
    assert_equal 9000, timer.alarm_seconds
  end

  test "alarm_time= should handle nil correctly" do
    timer = Timer.new(name: "Test Timer", alarm_seconds: 3600)
    timer.alarm_time = nil
    assert_nil timer.alarm_seconds
  end
end
