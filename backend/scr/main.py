from fastapi import FastAPI
from router import id_card, passport

app = FastAPI(title="OCR Backend")

app.include_router(id_card.router)
app.include_router(passport.router)
