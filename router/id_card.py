from fastapi import APIRouter, UploadFile, File
from service.ocr_service import scan_image
from parsers.id_card import parse_idcard

router = APIRouter(prefix="/idcard", tags=["ID Card"])

@router.post("/scan")
async def scan_idcard(file: UploadFile = File(...)):
    text = scan_image(
        await file.read(),
        file.filename,
        file.content_type
    )

    if not text:
        return {
            "fullName": None,
            "idCard": None,
            "birthDate": None,
            "issueDate": None,
            "expiryDate": None,
            "address": None,
            "error": "OCR_FAILED"
        }

    return parse_idcard(text)
