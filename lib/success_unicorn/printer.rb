module SuccessUnicorn
  class Printer

    def print(message:, failure: false)
      color = failure ? "31" : "32"
      puts "\n"
      puts "\e[#{color}m#{message}\e[0m"
    end
  end
end