require 'test_helper'

class EthnicitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ethnicity = ethnicities(:one)
  end

  test "should get index" do
    get ethnicities_url
    assert_response :success
  end

  test "should get new" do
    get new_ethnicity_url
    assert_response :success
  end

  test "should create ethnicity" do
    assert_difference('Ethnicity.count') do
      post ethnicities_url, params: { ethnicity: { name_en: @ethnicity.name_en, name_es: @ethnicity.name_es } }
    end

    assert_redirected_to ethnicity_url(Ethnicity.last)
  end

  test "should show ethnicity" do
    get ethnicity_url(@ethnicity)
    assert_response :success
  end

  test "should get edit" do
    get edit_ethnicity_url(@ethnicity)
    assert_response :success
  end

  test "should update ethnicity" do
    patch ethnicity_url(@ethnicity), params: { ethnicity: { name_en: @ethnicity.name_en, name_es: @ethnicity.name_es } }
    assert_redirected_to ethnicity_url(@ethnicity)
  end

  test "should destroy ethnicity" do
    assert_difference('Ethnicity.count', -1) do
      delete ethnicity_url(@ethnicity)
    end

    assert_redirected_to ethnicities_url
  end
end
