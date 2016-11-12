module SuccessUnicorn
  class MessageGenerator
    class << self

      def generate(examples)
        unless examples.all? {|example| example.respond_to?(:exception)}
          return error("One or more passed in objects does not respond to exception.")
        end
        examples.none?(&:exception) ? success : failure
      end

      def generate_for_exit_status(exit_object)
        unless exit_object.respond_to?(:exitstatus)
          return error("The passed in object does not respond to exitstatus.")
        end
        exit_object.exitstatus == 0 ? success : failure
      end


      private

      def success
        call_printer(message: success_text)
      end

      def failure
        call_printer(message: failure_text, failure: true)
      end

      def error(msg)
        call_printer(message: msg, failure: true)
      end

      def call_printer(message:, failure: false)
        printer ||= Printer.new
        printer.print(message: message, failure: failure)
      end

      def success_text
        <<END
                               ,|
                             //|                              ,|
                           //,/                             -~ |
                         // / |                         _-~   /  ,
                       /'/ / /                       _-~   _/_-~ |
                      ( ( / /'                   _ -~     _-~ ,/'
                       \\~\\/'/|             __--~~__--\\ _-~  _/,
               ,,)))))));, \\/~-_     __--~~  --~~  __/~  _-~ /
            __))))))))))))));,>/\\   /        __--~~  \\-~~ _-~
           -\\(((((''''(((((((( >~\\/     --~~   __--~' _-~ ~|
  --==//////((''  .     `)))))), /     ___---~~  ~~\\~~__--~
          ))| @    ;-.     (((((/           __--~~~'~~/
          ( `|    /  )      )))/      ~~~~~__\\__---~~__--~~--_
             |   |   |       (/      ---~~~/__-----~~  ,;::'  \\         ,
             o_);   ;        /      ----~~/           \\,-~~~\\  |       /|
                   ;        (      ---~~/         `:::|      |;|      < >
                  |   _      `----~~~~'      /      `:|       \\;\\_____//
            ______/\\/~    |                 /        /         ~------~
          /~;;.____/;;'  /          ___----(   `;;;/
         / //  _;______;'------~~~~~    |;;/\\    /
        //  | |                        /  |  \\;;,\\
       (<_  | ;                      /',/-----'  _>
        \\_| ||_                     //~;~~~~~~~~~
            `\\_|    SUCCESS        (,~~
                                    \\~\\
                                     ~~
END
      end

      def failure_text
        <<END
                    _-.                       .-_
                 _..-'(                       )`-.._
              ./'. '||\\\\.       (\\_/)       .//||` .`\\.
           ./'.|'.'||||\\\\|..    )*.*(    ..|//||||`.`|.`\\.
        ./'..|'.|| |||||\\```````  "  '''''''/||||| ||.`|..`\\.
      ./'.||'.|||| ||||||||||||.     .|||||||||||| ||||.`||.`\\.
     /'|||'.|||||| ||||||||||||{     }|||||||||||| ||||||.`|||`\\
    '.|||'.||||||| ||||||||||||{     }|||||||||||| |||||||.`|||.`
   '.||| ||||||||| |/'   ``\\||/`     '\\||/''   `\\| ||||||||| |||.`
   |/' \\./'     `\\./          |/\\   /\\|          \\./'     `\\./ `\\|
   V    V         V          }' `\\ /' `{          V         V    V
   `    `         `               U               '         '
                               FAILURE
END
      end
    end
  end

  class Printer
    def print(message:, failure: false)
      color = failure ? "31" : "32"
      puts "\n"
      puts "\e[#{color}m#{message}\e[0m"
    end
  end
end