from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()

@app.get("/")
def startmenue():
    return {"nachricht": "Startseite LOLOLOL"}

class ToDo(BaseModel):
    title: str
    erledigt: bool = False

todoListe = []
@app.post("/todo")
def create_todo(todo: ToDo):
    todoListe.append(todo)
    return {"message": "ToDo erstellt", "todo": todo}

@app.get("/todo")
def get_todos():
    return {"todos": todoListe}

@app.get("/todo/{index:int}")
def get_todo_by_index(index):
    if index >= 0 and index <= len(todoListe)-1:
        return {"todo": todoListe[index]}
    else:
        raise HTTPException(status_code=404, detail="To-do nicht gefunden")
