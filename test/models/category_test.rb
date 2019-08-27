require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'name must be upcase' do
    category = Category.new(name: 'yuri')

    category.save
    assert_equal 'YURI', category.name

    # uniqueness is not case sensitive
    other_category = Category.new(name: 'YURI')
    assert_not other_category.valid?
  end
end
