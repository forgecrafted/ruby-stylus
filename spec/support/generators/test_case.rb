# Extracted from generator_spec https://github.com/stevehodgkiss/generator_spec
# But `RSpec::Rails::RailsExampleGroup` loads a truckload of things from rails and rspec-rails
# That we don't need.

module Generators
  module TestCase
    extend ActiveSupport::Concern
    include FileUtils

    included do
      cattr_accessor :test_case, :test_case_instance

      self.test_case = Class.new(Rails::Generators::TestCase) do
        def fake_test_case; end
        def add_assertion; end
      end
      self.test_case_instance = self.test_case.new(:fake_test_case)
      self.test_case.tests described_class

      before do
        prepare_destination
        create_routes
        run_generator
      end

      destination File.expand_path("../tmp", __FILE__)
    end

    module ClassMethods
      def tests(klass)
        self.test_case.generator_class = klass
      end

      def arguments(array)
        self.test_case.default_arguments = array
      end

      def destination(path)
        self.test_case.destination_root = path
      end
    end

    module InstanceMethods

      def file(relative)
         File.expand_path(relative, destination_root)
       end

      def method_missing(method_sym, *arguments, &block)
        self.test_case_instance.send(method_sym, *arguments, &block)
      end

      def respond_to?(method_sym, include_private = false)
        if self.test_case_instance.respond_to?(method_sym)
          true
        else
          super
        end
      end
    end
  end
end