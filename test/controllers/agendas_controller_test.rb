require "test_helper"

class AgendasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get agendas_index_url
    assert_response :success
  end

  test "should get new" do
    get agendas_new_url
    assert_response :success
  end

  test "should get create" do
    get agendas_create_url
    assert_response :success
  end

  test "should get show" do
    get agendas_show_url
    assert_response :success
  end

  test "should get edit" do
    get agendas_edit_url
    assert_response :success
  end

  test "should get update" do
    get agendas_update_url
    assert_response :success
  end

  test "should get destroy" do
    get agendas_destroy_url
    assert_response :success
  end
end
