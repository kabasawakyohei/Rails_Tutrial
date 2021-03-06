require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User",
                     email: "user@example.com",
                     password: "foobar",
                     password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  # 名前に関するバリデーションtest
  test "name should be present" do
    @user.name = "     " 
    assert_not @user.valid?
  end

  test "name should be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  # メールアドレスに関するバリデーションtest
  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "email should be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
end
