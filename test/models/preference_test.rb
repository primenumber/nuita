require 'test_helper'

class PreferenceTest < ActiveSupport::TestCase
  def setup
    @user = users(:chikuwa)
    @category = categories(:r18g)
  end

  test "user and category have to be present, but don't have to be unique" do
    preference = Preference.create(user: @user, category: @category)
    assert preference.valid?

    no_user_preference = Preference.new(category: @category)
    assert_not no_user_preference.valid?

    no_category_preference = Preference.new(user: @user)
    assert_not no_category_preference.valid?

    dup_preference = Preference.new(user: @user, category: @category)
    assert dup_preference.valid?
  end
end
