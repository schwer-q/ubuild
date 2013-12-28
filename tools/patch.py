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
import sys

def list_patch(patch_dir):
        patchs = os.listdir(patch_dir)
        patchd = {}

        for patch in patchs:
                patch_id = int(patch.split('.')[0])
                patchd[patch_id] = patch

        patchds = sorted(patchd)
        patchs = []
        for patch_id in patchds:
                patchs.append(patchd[patch_id])

        return (patchs)

def main():
        argparser = argparse.ArgumentParser(description="Patch sources")
        argparser.add_argument("--patch-dir", type=str, help="Path to patchs")
        argparser.add_argument("--srcdir", type=str, help="Path to sources")

        args = argparser.parse_args(sys.argv[1:])
        if (args.patch_dir is None):
                print ("--path-dir is required")
                sys.exit(2)
        if (args.srcdir is None):
                print ("--srcdir is required")
                sys.exit(2)

        patchs = list_patch(args.patch_dir)

        os.chdir(args.srcdir)
        print ("===> Patching...")
        for patch in patchs:
                print ("==> %s" % patch)
                os.system("/usr/bin/patch -Np1 -i %s" % str(args.patch_dir + patch))

if __name__ == "__main__":
        main()
