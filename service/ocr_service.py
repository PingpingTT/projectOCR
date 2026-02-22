import requests, json
from config import TYPHOON_API_KEY, TYPHOON_OCR_URL

def scan_image(image_bytes, filename, content_type):
    response = requests.post(
        TYPHOON_OCR_URL,
        headers={
            "Authorization": f"Bearer {TYPHOON_API_KEY}"
        },
        files={
            "file": (filename, image_bytes, content_type)
        },
         data={
           "prompt": """
                คุณเป็นระบบแปลงข้อมูลบัตรประชาชนไทยจาก OCR
                อินพุตคือข้อความ OCR ดิบ อาจมีช่องว่างหรือรูปแบบไม่สม่ำเสมอ
                จงสกัดข้อมูลให้ครบถ้วนที่สุด

                ตอบกลับเป็น JSON เท่านั้น รูปแบบ:

                {
                "fullName": string | null,
                "idCard": string | null,
                "birthDate": string | null,
                "issueDate": string | null,
                "expiryDate": string | null,
                }

                กติกา:
                - รวมชื่อไทยเต็ม (คำนำหน้า + ชื่อ + นามสกุล)
                - เลขบัตรต้องเป็นตัวเลข 13 หลักติดกัน
                - วันที่ให้ใช้รูปแบบ DD/MM/YYYY
                - ถ้าไม่พบข้อมูลให้ใส่ null
                - ห้ามอธิบาย
                - ห้ามมีข้อความอื่นนอก JSON
                """
        },
        timeout=60,
    )

    response.raise_for_status()
    ocr_result = response.json()

    content = (
        ocr_result["results"][0]
        ["message"]["choices"][0]
        ["message"]["content"]
    )
    print("===== OCR TEXT =====")
    print(content)
    print("====================")

    if isinstance(content, str) and content.strip().startswith("{"):
        content = json.loads(content)

    if isinstance(content, dict):
        return content.get("natural_text", "")

    return content