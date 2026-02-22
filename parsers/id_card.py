import re
from .base import extract

def parse_idcard(text: str):
    id_card = extract(
        text,
        r"(\d{1}\s?\d{4}\s?\d{5}\s?\d{2}\s?\d{1})"
    )
    if id_card:
        id_card = re.sub(r"\s+", "", id_card)

    return {
        "fullName": extract(
            text,
            r"-\s*\*\*ชื่อตัวและชื่อสกุล:\*\*\s*([^\n]+)"
        ),
        "idCard": id_card,
        "birthDate": extract(
            text,
            r"-\s*\*\*เกิดวันที่:\*\*\s*([^\n]+)"
        ),
        "issueDate": extract(
            text,
            r"-\s*\*\*วันออกบัตร:\*\*\s*([^\n]+)"
        ),
        "expiryDate": extract(
            text,
            r"-\s*\*\*วันหมดอายุ:\*\*\s*([^\n]+)"
        ),
    }
