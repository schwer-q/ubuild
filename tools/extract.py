#!/usr/bin/python2
#
# Copyright (c) 2013, Quentin Schwerkolt
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice, this
#   list of conditions and the following disclaimer in the documentation and/or
#   other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

import argparse
import os
import re
import sys

def uncompress_command(file):
        uncompress = "/bin/cat"

        if (re.search("\.(bz2|tbz|tbz2)$", file) != None):
                uncompress = "/bin/bzip2 -c -d"
        elif (re.search("\.(gz|tgz)$", file) != None):
                uncompress = "/bin/gzip -c -d"
        elif (re.search("\.(txz|xz)$", file) != None):
                uncompress = "/usr/bin/xz -c -d"
        elif (re.search("\.Z$", file) != None):
                uncompress = "/bin/uncompress -c"
        return (uncompress)

def main():
        argparser = argparse.ArgumentParser(description="Extract archive")
        argparser.add_argument("--archive", type=str, help="Archive to extract")
        argparser.add_argument("--workdir", type=str, help="Where archive must be extracted")

        args = argparser.parse_args(sys.argv[1:])
        if (args.archive is None):
                print ("--archive is required")
                sys.exit(2)

        uncompress = uncompress_command(args.archive)
        extract = "/bin/tar -xf - --no-same-owner --no-same-permissions"
        os.chdir(args.workdir)
        os.system("%s %s | %s" % (uncompress, args.archive, extract))

if __name__ == "__main__":
        main()
