module SuccessUnicorn
  class MessageGenerator
    class << self
      def generate(examples)
        examples.none?(&:exception) ? success : error
      end


      private

      def success
        call_printer(message: success_text)
      end

      def error
        call_printer(message: error_text, failure: true)
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

      def error_text
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