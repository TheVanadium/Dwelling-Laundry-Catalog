import sqlite3
from modifyData import *
from insert_data import do_laundry

# prompts user for name until name is found in database
def get_username(db: sqlite3.Connection) -> str:
    cursor = db.cursor()
    cursor.execute("SELECT name FROM owner;")
    owners = cursor.fetchall()
    for owner in owners:
        print(owner[0])
    username = str(input("Enter your name: "))
    if username in [owner[0] for owner in owners]:
        return username
    print("Name not found. Please try again.")
    return get_username(db)

def get_menu_option(db: sqlite3.Connection) -> int:
    print("1. Do Laundry")
    print("2. Mark things as dirty")
    print("3. Edit")
    print("4. Exit")
    option = input("Select an option: ")
    # check if input is a number
    if not option.isdigit():
        print("Invalid option. Please try again.")
        return get_menu_option(db)
    int_option = int(option)
    if int_option < 1 or int_option > 4:
        print("Invalid option. Please try again.")
        return get_menu_option(db)
    return int_option

def open_dirty_menu(db: sqlite3.Connection, username: str) -> None:
    cursor = db.cursor()

    # get all laundry in ownedby table where name = username
    laundry_ids = cursor.execute("SELECT id FROM OwnedBy WHERE name = ?;", (username,)).fetchall()
    laundry = cursor.execute("SELECT * FROM laundry WHERE id IN ({});".format(", ".join([str(laundry_id[0]) for laundry_id in laundry_ids]))).fetchall()
    
    ids: list[int] = []
    all_laundry_dirty = True
    for item in laundry:
        if not int(item[4]):
            all_laundry_dirty = False
        ids.append(item[0])
        print(f"ID: {item[0]}, Description: {item[1]} - {('DIRTY' if int(item[4]) else 'CLEAN')}")
    
    if all_laundry_dirty:
        print("All laundry is dirty.")
        return

    dirty_id = input("Enter the ID of the item you want to mark as dirty (Enter -1 to exit): ")
    if dirty_id == "-1":
        return
    if dirty_id.isdigit() and int(dirty_id) not in ids:
        print("Invalid ID. Please try again.")
        return open_dirty_menu(db, username)

    cursor = db.cursor()
    cursor.execute("UPDATE laundry SET dirty = 1 WHERE id = ?;", (dirty_id,))
    db.commit()
    print(f"Item {dirty_id} marked as dirty.")
    open_dirty_menu(db, username)

def edit(db: sqlite3.Connection, username: str) -> None:
    cursor = db.cursor()
    print("1. Laundry")
    print("2. Detergent")
    print("3. User")
    print("4. Cleaner")
    option = input("Select an option: ")
    if not option.isdigit():
        print("Invalid option. Please try again.")
        return edit(db, username)
    int_option = int(option)
    if int_option < 1 or int_option > 4:
        print("Invalid option. Please try again.")
        return edit(db, username)
    if int_option == 1:
        edit_laundry(db, username)
    elif int_option == 2:
        edit_detergent(db)
    elif int_option == 3:
        edit_user(db)
    else:
        edit_cleaner(db)

def execute_menu_option(menu_option: int, db: sqlite3.Connection, username: str) -> None:
    match menu_option:
        case 1:
            do_laundry(db, username)
        case 2:
            open_dirty_menu(db, username)
        case 3:
            edit(db, username)
        case 4:
            db.close()
            exit()
        case _:
            print("Invalid option. Please try again.")
    execute_menu_option(get_menu_option(db), db, username)

# First, enter name

# menu items
# 1. Do Laundry
# 2. Mark things as dirty
# 3. Edit (Insert/Delete/Update)
#  a. Laundry
    # if it's a new color, ask if it's dark or light
#  b. Detergent
#  c. User
#  d. Cleaner

db = sqlite3.connect("Checkpoint2-dbase.sqlite3")

# establish foreign key constraints
db.execute("PRAGMA foreign_keys = ON;")
db.commit()

cursor = db.cursor()

username = get_username(db)
execute_menu_option(get_menu_option(db), db, username)
