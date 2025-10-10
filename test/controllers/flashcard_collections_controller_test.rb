require "test_helper"

class FlashcardCollectionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get flashcard_collections_index_url
    assert_response :success
  end

  test "should get new" do
    get flashcard_collections_new_url
    assert_response :success
  end

  test "should get create" do
    get flashcard_collections_create_url
    assert_response :success
  end

  test "should get show" do
    get flashcard_collections_show_url
    assert_response :success
  end

  test "should get edit" do
    get flashcard_collections_edit_url
    assert_response :success
  end

  test "should get update" do
    get flashcard_collections_update_url
    assert_response :success
  end

  test "should get destroy" do
    get flashcard_collections_destroy_url
    assert_response :success
  end
end
