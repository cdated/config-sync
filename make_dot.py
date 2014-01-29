#!/usr/bin/env python

import sys
import re
import os

files_in_tree = {}
inspect = {}

include_regex = r'#include [<"](.*)[>"]'

def inspect_file(file_name):
    if not file_name in files_in_tree:
        return

    file_obj = open(files_in_tree[file_name])

    inspect[file_name] = True
    for line in file_obj:
        match = re.match(include_regex, line)
        if match:
            dep = match.group(1)
            print('\t"%s" -> "%s"' % (file_name, dep))

            if not dep in inspect:
                inspect_file(dep)

    file_obj.close()

def main():
    initial_file = sys.argv[1]
    root_path = sys.argv[2]

    files_in_tree[initial_file] = initial_file

    for root, dirs, files in os.walk(root_path):
        for name in files:
            if not ".git" in root:
                abs_file_path = os.path.abspath(os.path.join(root, name))
                if not name in files_in_tree:
                    files_in_tree[name] = abs_file_path

    print('digraph "source tree" {')
    inspect_file(initial_file)

    for source_file in files_in_tree:
        inspect_file(source_file)
    print('}')

if __name__ == '__main__':
    main()
