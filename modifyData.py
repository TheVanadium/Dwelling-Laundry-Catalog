import sqlite3

def connect_db():
    conn = sqlite3.connect("Checkpoint2-dbase.sqlite3")
    return conn

def insert_owner(
    name: str,
    allergies: list[str] = [],
    can_wash: list[str] = [],
    liked_cleaners: list[str] = [],
    db: sqlite3.Connection = connect_db()
) -> None:
    cursor = db.cursor()

    try:
        cursor.execute("INSERT INTO owner VALUES (?);", (name,))
    except sqlite3.IntegrityError:
        print(f"Owner {name} already exists in the database.")
        db.rollback() 

    if allergies:
        for allergy in allergies:
            try:
                # First ensure the ingredient exists
                cursor.execute(
                    "INSERT OR IGNORE INTO detergent_ingredient VALUES (?);", 
                    (allergy,)
                )
                # Then create the allergy relationship
                cursor.execute(
                    "INSERT INTO IsAllergicTo VALUES (?, ?);",
                    (name, allergy)
                )
            except sqlite3.IntegrityError:
                print(f"Allergy {allergy} already recorded for {name}")
                db.rollback()

    if can_wash:
        for washee in can_wash:
            try:
                cursor.execute(
                    "INSERT INTO OwnerCanWash VALUES (?, ?);",
                    (name, washee)
                )
            except sqlite3.IntegrityError:
                print(f"Wash permission {name}->{washee} already exists")
                db.rollback()

    if liked_cleaners:
        for cleaner in liked_cleaners:
            try:
                cursor.execute(
                    "INSERT INTO Likes VALUES (?, ?);",
                    (cleaner, name)
                )
            except sqlite3.IntegrityError:
                print(f"Like relationship {name}->{cleaner} already exists")
                db.rollback()

    cursor.close()
    db.commit()
    db.close()

def insert_cleaners(
    address: str,
    name: str,
    supported_systems: list[tuple[str, str, str]] = [],  # List of (wash_method, detergent, dry_method)
    db: sqlite3.Connection = connect_db()
) -> None:
    cursor = db.cursor()

    try:
        cursor.execute(
            "INSERT INTO cleaners VALUES (?, ?);",
            (address, name)
        )
    except sqlite3.IntegrityError:
        print(f"Cleaner at address {address} already exists in the database.")

    if supported_systems:
        for system in supported_systems:
            wash_method, detergent, dry_method = system
            try:
                # First ensure the cleaning system exists
                cursor.execute(
                    "INSERT OR IGNORE INTO cleaning_system VALUES (?, ?, ?);",
                    (wash_method, detergent, dry_method)
                )
                # Then create the support relationship
                cursor.execute(
                    "INSERT INTO SupportsCleaningSystem VALUES (?, ?, ?, ?);",
                    (address, wash_method, detergent, dry_method)
                )
            except sqlite3.IntegrityError:
                print(f"System support {address}->{system} already exists")

    cursor.close()
    db.commit()
    db.close()

def insert_laundry(
    owner: str,
    description: str,
    location: str = "",
    special_instructions: str = "",
    dirty: bool = False,
    volume: int = 0,
    detergents: list[str] = [],
    color: str = "",
    db: sqlite3.Connection = connect_db(),
) -> None:
    cursor = db.cursor()
    cursor.execute("SELECT MAX(id) FROM laundry;")
    laundry_id = cursor.fetchone()[0]
    if laundry_id is None:
        laundry_id = 1
    else:
        laundry_id += 1

    cursor.execute(
        "INSERT INTO laundry VALUES (?, ?, ?, ?, ?, ?);",
        (laundry_id, description, location, special_instructions, dirty, volume),
    )

    if detergents:
        for detergent in detergents:
            cursor.execute(
                "INSERT INTO Deterges VALUES (?, ?);", (laundry_id, detergent)
            )

    if color:
        cursor.execute("INSERT INTO IsColor VALUES (?, ?);", (color, laundry_id))

    if owner:
        cursor.execute("INSERT INTO OwnedBy VALUES (?, ?);", (owner, laundry_id))

    cursor.close()
    db.commit()
    db.close()


def insert_detergent(
    name: str,
    for_darks: bool,
    for_whites: bool,
    whitens: bool,
    ingredients: list[str],
    db: sqlite3.Connection = connect_db(),
) -> None:
    db = connect_db()
    cursor = db.cursor()

    try:
        cursor.execute(
            "INSERT INTO detergent VALUES (?, ?, ?, ?);",
            (name, for_darks, for_whites, whitens),
        )
    except sqlite3.IntegrityError:
        print(f"Detergent {name} already exists in the database.")

    if ingredients:
        for ingredient in ingredients:
            try:
                cursor.execute(
                    f"INSERT INTO DetergentComposedOf VALUES (?, ?)", (name,ingredient,)
                )
                cursor.execute(
                    f"INSERT INTO detergent_ingredient VALUES (?)", (ingredient,)
                )
            except sqlite3.IntegrityError:
                print(f"Ingredient {ingredient} already exists in the database.")

    cursor.close()
    db.commit()
    db.close()

def delete_owner(
    name: str,
    db: sqlite3.Connection = connect_db()
) -> None:
    cursor = db.cursor()

    try:
        # Delete from related tables first due to foreign key constraints
        cursor.execute("DELETE FROM IsAllergicTo WHERE owner = ?;", (name,))
        cursor.execute("DELETE FROM OwnerCanWash WHERE washer = ? OR washee = ?;", (name, name))
        cursor.execute("DELETE FROM Likes WHERE owner = ?;", (name,))
        cursor.execute("DELETE FROM laundry WHERE id IN (SELECT id FROM OwnedBy WHERE name = ?);", (name,))
        cursor.execute("DELETE FROM OwnedBy WHERE name = ?;", (name,))
        # Finally delete the owner
        cursor.execute("DELETE FROM owner WHERE name = ?;", (name,))
        print(f"Owner {name} and related data deleted successfully.")
    except sqlite3.Error as e:
        print(f"Error deleting owner {name}: {e}")

    cursor.close()
    db.commit()
    db.close()

def delete_cleaners(
    address: str,
    db: sqlite3.Connection = connect_db()
) -> None:
    cursor = db.cursor()

    try:
        # Delete from related tables first
        cursor.execute("DELETE FROM SupportsCleaningSystem WHERE cleaners = ?;", (address,))
        cursor.execute("DELETE FROM Likes WHERE cleaners = ?;", (address,))
        # Delete the cleaner
        cursor.execute("DELETE FROM cleaners WHERE address = ?;", (address,))
        print(f"Cleaner at {address} and related data deleted successfully.")
    except sqlite3.Error as e:
        print(f"Error deleting cleaner at {address}: {e}")

    cursor.close()
    db.commit()
    db.close()

def delete_laundry(
    laundry_id: int,
    db: sqlite3.Connection = connect_db()
) -> None:
    cursor = db.cursor()

    try:
        # Delete from related tables first
        cursor.execute("DELETE FROM Deterges WHERE laundry = ?;", (laundry_id,))
        cursor.execute("DELETE FROM IsColor WHERE laundry = ?;", (laundry_id,))
        cursor.execute("DELETE FROM OwnedBy WHERE id = ?;", (laundry_id,))
        cursor.execute("DELETE FROM CleanedBy WHERE laundry = ?;", (laundry_id,))
        # Delete the laundry item
        cursor.execute("DELETE FROM laundry WHERE id = ?;", (laundry_id,))
        print(f"Laundry item {laundry_id} and related data deleted successfully.")
    except sqlite3.Error as e:
        print(f"Error deleting laundry item {laundry_id}: {e}")

    cursor.close()
    db.commit()
    db.close()

def delete_detergent(
    name: str,
    db: sqlite3.Connection = connect_db()
) -> None:
    cursor = db.cursor()

    try:
        # Delete from related tables first
        cursor.execute("DELETE FROM DetergentComposedOf WHERE detergent = ?;", (name,))
        cursor.execute("DELETE FROM Deterges WHERE detergent = ?;", (name,))
        cursor.execute("DELETE FROM cleaning_system WHERE detergent = ?;", (name,))
        # Delete the detergent
        cursor.execute("DELETE FROM detergent WHERE name = ?;", (name,))
        print(f"Detergent {name} and related data deleted successfully.")
    except sqlite3.Error as e:
        print(f"Error deleting detergent {name}: {e}")

    cursor.close()
    db.commit()
    db.close()
