use "pprint/base.fun";
use "pprint/config.sig";

structure MyConfig: PPrintConfig =
   struct
      type config = {indent: int, page_width: int}
      val config =  { indent = 3, page_width = 72 }
   end;

structure MyPrintBase =  PPrintBase(MyConfig)

val state =  MyPrintBase.init;

(
   MyPrintBase.print_tok (TextIO.stdOut, "Hello") state;
   MyPrintBase.print_close_par (TextIO.stdOut, ",") state;
   MyPrintBase.print_tok (TextIO.stdOut, "World") state;
   MyPrintBase.print_period (TextIO.stdOut, "!") state;
   MyPrintBase.print_tok (TextIO.stdOut, "Ciao") state;
   MyPrintBase.print_period (TextIO.stdOut, "!") state;
   MyPrintBase.print_ws (TextIO.stdOut, " ") state;
   MyPrintBase.print_open_par (TextIO.stdOut, "(") state;
   MyPrintBase.print_open_par (TextIO.stdOut, "(") state;
   MyPrintBase.print_tok (TextIO.stdOut, "inside pars") state;
   MyPrintBase.print_close_par (TextIO.stdOut, ")") state;
   MyPrintBase.print_close_par (TextIO.stdOut, ")") state;
   MyPrintBase.force_ws state;
   MyPrintBase.print_close_par (TextIO.stdOut, ")") state;
   MyPrintBase.print_tok (TextIO.stdOut, "after all the pars") state;
   MyPrintBase.navigate_to_pos (TextIO.stdOut, 30) state;
   MyPrintBase.print_tok (TextIO.stdOut, "Hello world!") state;
   MyPrintBase.print_nl(TextIO.stdOut) state );
