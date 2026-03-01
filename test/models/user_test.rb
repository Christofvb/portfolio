require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid with email and password" do
    user = User.new(email: "test@example.com", password: "password123")
    assert user.valid?
  end

  test "invalid without email" do
    user = User.new(password: "password123")
    assert_not user.valid?
    assert user.errors[:email].any?
  end

  test "invalid with duplicate email" do
    existing = users(:admin)
    user = User.new(email: existing.email, password: "password123")
    assert_not user.valid?
    assert user.errors[:email].any?
  end

  test "invalid with short password" do
    user = User.new(email: "new@example.com", password: "short")
    assert_not user.valid?
  end
end
