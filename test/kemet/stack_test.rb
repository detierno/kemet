# frozen_string_literal: true

require "test_helper"

module Kemet
  class StackTest < Minitest::Test
    def setup
      @stack = Kemet::Stack.new
    end

    def test_add_pushes_events_to_stack
      @stack.add(:event)

      event = @stack.instance_variable_get(:@queue).first
      assert_equal :event, event
    end

    def test_add_pushes_multiple_events_to_queue
      @stack.add(:event)
      @stack.add(:event)

      queue = @stack.instance_variable_get(:@queue)
      assert_equal 2, queue.size
    end

    def test_any_is_false_with_no_entries
      refute @stack.any?
    end

    def test_any_is_true_with_entries
      @stack.instance_variable_set(:@queue, [:foo])
      assert @stack.any?
    end

    def test_pop_return_first_element_added_to_queue
      @stack.instance_variable_set(:@queue, %i[foo bar])
      assert_equal :foo, @stack.pop!
    end
  end
end
