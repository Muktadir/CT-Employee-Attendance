require 'test_helper'

class AllowedIpsControllerTest < ActionController::TestCase
  setup do
    @allowed_ip = allowed_ips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:allowed_ips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create allowed_ip" do
    assert_difference('AllowedIp.count') do
      post :create, allowed_ip: { ip_address: @allowed_ip.ip_address, name: @allowed_ip.name }
    end

    assert_redirected_to allowed_ip_path(assigns(:allowed_ip))
  end

  test "should show allowed_ip" do
    get :show, id: @allowed_ip
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @allowed_ip
    assert_response :success
  end

  test "should update allowed_ip" do
    patch :update, id: @allowed_ip, allowed_ip: { ip_address: @allowed_ip.ip_address, name: @allowed_ip.name }
    assert_redirected_to allowed_ip_path(assigns(:allowed_ip))
  end

  test "should destroy allowed_ip" do
    assert_difference('AllowedIp.count', -1) do
      delete :destroy, id: @allowed_ip
    end

    assert_redirected_to allowed_ips_path
  end
end
