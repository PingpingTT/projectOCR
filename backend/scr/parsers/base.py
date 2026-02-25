import re

def extract(text, pattern):
    m = re.search(pattern, text, re.MULTILINE)
    return m.group(1).strip() if m else None
