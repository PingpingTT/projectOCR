from fastapi import APIRouter, UploadFile, File
from service.ocr_service import scan_image
from parsers.passport import parse_passport

router = APIRouter(
    prefix="/passport",
    tags=["passport"]
)

@router.post("/scan")
async def scan_passport(file: UploadFile = File(...)):
    image_bytes = await file.read()

    text = scan_image(
        image_bytes=image_bytes,
        filename=file.filename,
        content_type=file.content_type
    )

    result = parse_passport(text)

    return {
        "passport": result
    }
