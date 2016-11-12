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
  end

  it "when examples have exceptions it calls printer to print a spooky bat" do
    example = double("RSpec Example", exception: "uh oh")
    @logger.generate([example])

    expect(@printer).to have_received(:print).with(message: @logger.send(:error_text), failure: true)
  end
end