require 'test_helper'
require 'tins'

module Tins
  class AnnotateTest < Test::Unit::TestCase
    require 'tins/xt/annotate'

    class A
      annotate :foo

      annotate :bar

      foo 'test foo1'
      bar 'test bar1'
      def first
      end

      foo 'test foo2'
      bar 'test bar2'
      def second
      end

      bar 'test bar3'
      def third
      end
    end

    def test_annotations_via_class
      assert_equal 'test foo1', A.foo_of(:first)
      assert_equal 'test bar1', A.bar_of(:first)
      assert_equal 'test foo2', A.foo_of(:second)
      assert_equal 'test bar2', A.bar_of(:second)
      assert_equal nil, A.foo_of(:third)
      assert_equal 'test bar3', A.bar_of(:third)
    end

    def test_annotations_via_instance
      a = A.new
      assert_equal 'test foo1', a.foo_of(:first)
      assert_equal 'test bar1', a.bar_of(:first)
      assert_equal 'test foo2', a.foo_of(:second)
      assert_equal 'test bar2', a.bar_of(:second)
      assert_equal nil, a.foo_of(:third)
      assert_equal 'test bar3', a.bar_of(:third)
    end
  end
end
