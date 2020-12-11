import math
import os
import re

for root,dirs,files in os.walk("."):
    for f in files:
        if f.endswith(".lua"):
            full = os.path.join(root, f)
            print(full)
            with open(full, "r") as fd:
                content = content1 = fd.read()
                m = True
                while m:
                    m = re.search(r"(\d+) / 2", content)
                    if m:
                        lhs = int(m.group(1))
                        pe = math.floor(lhs / 2)
                        start, end = m.span()
                        content = content[:start] + str(pe) + content[end:]
            if content != content1:
                print("rewritten")
                with open(full, "w") as fd:
                    fd.write(content)
