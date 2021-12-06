#!/usr/bin/env python
# coding: utf-8

import os
import glob
from slugify import slugify
from tqdm import tqdm


files = glob.glob('./data/editions/*.xml')

replace_patterns = []
for x in tqdm(files, total=len(files)):
    head, tail = os.path.split(x)
    first_letter = tail[0]
    new_name = (slugify(tail.split('.xml')[0]))
    try:
        int(first_letter)
        new_name = f"a-{(slugify(tail.split('.xml')[0]))}.xml"
    except ValueError:
        new_name = f"{slugify(tail.split('.xml')[0])}.xml"
    new_full_name = os.path.join('data', 'editions', new_name)
    replace_patterns.append(
        [tail, new_name]
    )
    os.rename(x, new_full_name)

print(replace_patterns)

# files = glob.glob('./data/editions/*.xml')

# for file in tqdm(files, total=len(files)):
#     with open(file) as cur_file:
#         data = cur_file.read()
#     for x in replace_patterns:
#         data = data.replace(x[0], x[1])
#     with open(file, "w") as cur_file:
#         cur_file.write(data)

print("done")
