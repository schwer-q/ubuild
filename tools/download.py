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

from urllib import splittype
from urllib2 import urlopen
import argparse
import hashlib
import os
import sys

def printIOError(e, msg):
        print ("I/O Error: " + msg + ": ")
        try:
                (code, message) = e
                print (str(message) + "(" + str(code) + ")")
        except:
                print (str(e))

def download(url, file = None):
        dst = None
        src = None
        length = -1

        print "downloading...",
        try:
                src = urlopen(url)
        except IOError as e:
                printIOError(e, "Can't open url " + url)
                return (None)

        if (src.getcode() and (3 <= int(src.getcode() / 100) <= 5)):
                print ("Error code: " + str(src.getcode()))
                return (None)

        if (file == None):
                file = url.split('/')[-1]

        chunk_sz = 8192
        chunk_sz = 1024
        down_sz = 0
        file_sz = int(src.headers["Content-Length"])

        try:
                dst = open(file, "wb")
        except IOError as e:
                printIOError(e, "Can't open file " + file + "for writing")
                src.close()
                return (None)

        while True:
                buffer = src.read(chunk_sz)
                if buffer == '':
                        break

                down_sz += len(buffer)
                dst.write(buffer)
                status = r"%10d [%3.2f%%]" % (down_sz, down_sz * 100. / file_sz)
                status = status + chr(8) * (len(status) + 1)
                print status,

        dst.close()
        dst.close()
        return (file)

def validate(_file, hash):
        algorithm, hashvalue = hash.split(':')
        m = None
        file = None

        try:
                m = hashlib.new(algorithm)
        except ValueError:
                return False

        try:
                file = open(_file, "r")
        except IOError as e:
                printIOError(e, "Can't open file" + _file)
                return (False)

        while True:
                try:
                        chunk = file.read()
                except IOError as e:
                        print (str(e))
                        break

                m.update(chunk)
                if (chunk == ''):
                        break
        return ("%s:%s" % (algorithm, m.hexdigest()))

def main():
        argparser = argparse.ArgumentParser(description="Download files")
        argparser.add_argument("--dest", type=str, help="Output file")
        argparser.add_argument("--hash", type=str, help="Expected hash for file")
        argparser.add_argument("--link", action="store_true", help="Link for file scheme")
        argparser.add_argument("--url", type=str, help="Url of the file to fetch")

        args = argparser.parse_args(sys.argv[1:])
        if (args.url == None):
                print ("--url is required.")
                sys.exit(2)

        print ("%s" % args.url.split('/')[-1])

        file = None
        scheme, path = splittype(args.url)

        if (scheme in [None, "file"]):
                pass
        elif (scheme in ["http", "https", "ftp"]):
                file = download(args.url, args.dest)
                if (file is None):
                        print ("Failed")
                        sys.exit(1)

        print "\nvalidating...",
        if (args.hash is None):
                print ("Skipping (no hash)")
                sys.exit(0)
        realhash = validate(file, args.hash)
        if (realhash == args.hash):
                print ("Ok")
                sys.exit(0)
        else:
                print ("Corruption detected:")
                print ("\tExpected: %s" % args.hash)
                print ("\tActual:   %s" % realhash)
        try:
                os.remove(file)
        except OSError:
                pass
        sys.exit(1)


if __name__ == "__main__":
        main()
