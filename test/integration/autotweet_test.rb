require 'test_helper'

class AutotweetTest < ActionDispatch::IntegrationTest
  def setup
    Nuita::Application.load_tasks
    @user = users(:girl) # no twitter
  end

  test 'task(disable_autotweet_with_no_account) test' do
    @user.update_attribute(:autotweet_enabled, true)

    Rake::Task['twitter_task:disable_autotweet_with_no_account'].invoke
    assert_empty User.where(autotweet_enabled: true)
  end
end
