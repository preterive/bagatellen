import dctbnbc.evaluate
import dctbnbc.tokenize
import feedparser
import getopt
import json
import sys

def print_usage(file):
   file.write("\nUSAGE:\n\n")
   file.write("%s [-h|--help]\n" % sys.argv[0])
   file.write("   write this usage information.\n\n")
   file.write("%s [{-f|--file} <site_files] ... [<feed_url>] ...\n" % sys.argv[0])
   file.write("   extract authors appearing in <feed_url> or appearing in feed urls contained in <site_files>.\n\n")


def interpret_cmdline(result):

   retval =  "OK"

   try:
      optlist, args =  getopt.getopt(sys.argv[1:], "hf:", [ "help", "file" ])

      if "files" not in result.keys():
         result["files"] =  []

      if "urls" not in result.keys():
         result["urls"] =  []

      for option, arg in optlist:
         if option in { "-h", "--help" }:
            if retval == "OK":
               print_usage(sys.stdout)
               retval =  "HelpMode"
         elif option in { "-f", "--file" }:
            result["files"].append(arg)
         else:
            sys.stderr.write("option %s not permitted.\n\n" % option)
            retval =  "Error"

      for arg in args:
         result["urls"].append(arg)

   except getopt.GetoptError as err:
      sys.stderr.write("%s\n\n" % str(err))
      retval =  "Error"

   if retval == "Error":
      print_usage(sys.stderr)

   return retval


# interprete cmdline.
cmdline_params =  {}
retval =  interpret_cmdline(cmdline_params)
if retval == "Error":
   sys.exit(2)
elif retval == "HelpMode":
   sys.exit(0)

raw_data =  sys.stdin.read()
knowledge =  json.loads(raw_data)

url_set =  set(cmdline_params["urls"])
for f in cmdline_params["files"]:
   try:
      with open(f) as fd:
         raw_f_data =  fd.read()
         json_f_data =  json.loads(raw_f_data)
         if "sites" in json_f_data and isinstance(json_f_data["sites"], list):
            for site in json_f_data["sites"]:
               if "href" in site:
                  url_set.add(site["href"])
               else:
                  sys.stderr.write("href key is missing in a element of list assigned to sites key in json file %s given in -f cmdline param.\n" % f)
         else:
            sys.stderr.write("json file %s given in a -f cmdline param has no sites key assigned with a list of sites.\n" % f)
   except FileNotFoundError:
      sys.stderr.write("%s given in a -f cmdline param not found.\n" % f)
      sys.exit(2)

result_list =  []
for url in url_set:
   tally_sheet =  {
         "nr": 1
      ,  "abundance": {} }
   fp =  feedparser.parse(url)
   for entry in fp["entries"]:
      if "summary" in entry.keys():
         content =  entry["summary"]
         token_list =  dctbnbc.tokenize.tokenize(content)
         dctbnbc.tokenize.tally_token_list(tally_sheet, token_list)
   score =  dctbnbc.tokenize.score(tally_sheet, knowledge)
   result_list.append((score, url))
result_list.sort()

for (v, k) in result_list:
   print(k, v)
