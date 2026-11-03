import re
import sys

du_file, src, dst = sys.argv[1], sys.argv[2], sys.argv[3]

with open(src, encoding="latin-1") as fin, open(dst, "w", encoding="latin-1") as fout:
    for line in fin:
        if not line.startswith("C "):
            fout.write(line)
            continue
        if f"\x01f\x02{du_file}\x01" not in line:
            continue
        line = re.sub(r"\x01h\x02[^\x01']*", "\x01h\x02dut", line)
        line = re.sub(r"(\x01page\x02[^\x01']*?)__U\d+", r"\1", line)
        fout.write(line)