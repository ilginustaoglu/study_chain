require "test_helper"

class StudyMaterialsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get study_materials_index_url
    assert_response :success
  end

  test "should get new" do
    get study_materials_new_url
    assert_response :success
  end

  test "should get create" do
    get study_materials_create_url
    assert_response :success
  end

  test "should get show" do
    get study_materials_show_url
    assert_response :success
  end

  test "should get edit" do
    get study_materials_edit_url
    assert_response :success
  end

  test "should get update" do
    get study_materials_update_url
    assert_response :success
  end

  test "should get destroy" do
    get study_materials_destroy_url
    assert_response :success
  end
end
