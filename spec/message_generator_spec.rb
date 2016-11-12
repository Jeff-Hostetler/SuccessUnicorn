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
      exit_status = 0
      @logger.generate_for_exit_status(exit_status)

      expect(@printer).to have_received(:print).with(message: @logger.send(:success_text), failure: false)
    end

    specify "when the exitstatus is not 0 it calls the printer with failure text" do
      exit_status = "not zero"
      @logger.generate_for_exit_status(exit_status)

      expect(@printer).to have_received(:print).with(message: @logger.send(:failure_text), failure: true)
    end
  end
end