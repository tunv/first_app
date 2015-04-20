require 'test_helper'

class UserTest < ActiveSupport::TestCase
   def setup
    @user = User.new(name: "Nguyen", email: "user@example.com",password: "admin123", password_confirmation: "admin123")
  end

  test "should be valid" do
    assert @user.valid?
  end
test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert duplicate_user.invalid?
  end
   test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 15
    assert @user.valid?
  end
end
