require "rspec"
require_relative "../lib/success_unicorn.rb"

describe SuccessUnicorn::MessageGenerator do
  before do
    @logger = SuccessUnicorn::MessageGenerator
    @printer = instance_double(SuccessUnicorn::Printer, print: "string passed in with color")

    allow(SuccessUnicorn::Printer).to receive(:new).and_return(@printer)
  end
  describe ".generate" do
    specify "when there are no exceptions in the examples it calls printer to print a unicorn" do
      example = double("RSpec Example", exception: nil)
      @logger.generate([example])

      expect(@printer).to have_received(:print).with(message: @logger.send(:success_text), failure: false)
    end

    it "when examples have exceptions it calls printer to print a spooky bat" do
      example = double("RSpec Example", exception: "uh oh")
      @logger.generate([example])

      expect(@printer).to have_received(:print).with(message: @logger.send(:failure_text), failure: true)
    end

    specify "when the passed in objects does not respond to exception it calls printer to log error" do
      example = double("RSpec Example", exception: "uh oh")
      some_other_thing = double("Some other thing")
      @logger.generate([example, some_other_thing])

      expect(@printer).to have_received(:print).with(message: "One or more passed in objects does not respond to exception.", failure: true)
    end
  end

  describe ".generate_for_exit_status" do
    specify "when the exitstatus is 0 it calls the printer with success text" do
      exit_object = double("Bash exit object", exitstatus: 0)
      @logger.generate_for_exit_status(exit_object)

      expect(@printer).to have_received(:print).with(message: @logger.send(:success_text), failure: false)
    end

    specify "when the exitstatus is not 0 it calls the printer with failure text" do
      exit_object = double("Bash exit object", exitstatus: "something other than 0")
      @logger.generate_for_exit_status(exit_object)

      expect(@printer).to have_received(:print).with(message: @logger.send(:failure_text), failure: true)
    end

    specify "when the passed in parameter does not respond to exit status it calls printer to log error" do
      exit_object = double("Bash exit object")
      @logger.generate_for_exit_status(exit_object)

      expect(@printer).to have_received(:print).with(message: "The passed in object does not respond to exitstatus.", failure: true)
    end
  end
end