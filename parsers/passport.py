import re
from .base import extract

def parse_passport(text: str):
    return {
        "passport_no": extract(text, r"Passport No.*?([A-Z0-9]{6,9})"),
        "surname": extract(text, r"Surname.*?\n\s*-?\s*([A-Z\s]+)(?:\n|$)"),
        "given_name": extract(text, r"Given names.*?\n\s*-?\s*([A-Z\s]+)(?:\n|$)"),
        "nationality": extract(text, r"Nationality.*?\n\s*-?\s*([A-Z\s]+)(?:\n|$)"),
        "birth_date": extract(text, r"Date of birth.*?\n\s*-?\s*([0-9]{2}\s+[A-Z]{3}.*?[0-9]{2})"),
        "issue_date":extract(text, r"Date of issue.*?\n\s*-?\s*([0-9]{2}\s+[A-Z]{3}.*?[0-9]{2})"),
        "expiry_date": extract(text, r"Date of expiry.*?\n\s*-?\s*([0-9]{2}\s+[A-Z]{3}.*?[0-9]{2})")
    }
