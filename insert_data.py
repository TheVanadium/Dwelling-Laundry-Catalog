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

    if can_wash:
        for washee in can_wash:
            try:
                cursor.execute(
                    "INSERT INTO OwnerCanWash VALUES (?, ?);",
                    (name, washee)
                )
            except sqlite3.IntegrityError:
                print(f"Wash permission {name}->{washee} already exists")

    if liked_cleaners:
        for cleaner in liked_cleaners:
            try:
                cursor.execute(
                    "INSERT INTO Likes VALUES (?, ?);",
                    (cleaner, name)
                )
            except sqlite3.IntegrityError:
                print(f"Like relationship {name}->{cleaner} already exists")

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
    db: sqlite3.Connection = connect_db(),
    location: str = "",
    special_instructions: str = "",
    dirty: bool = False,
    volume: int = 0,
    detergents: list[str] = [],
    color: str = "",
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
                    f"INSERT INTO detergent_ingredient VALUES (?)", (ingredient,)
                )
            except sqlite3.IntegrityError:
                print(f"Ingredient {ingredient} already exists in the database.")

    cursor.close()
    db.commit()
    db.close()


if __name__ == "__main__":
    db = connect_db()

    insert_laundry(
        owner="John Doe",
        description="A pair of jeans",
        db=db,
        location="Laundry basket",
        special_instructions="Wash with cold water",
        dirty=True,
        volume=1,
        detergents=["Tide"],
        color="blue",
    )

    insert_detergent(
        name="Tide",
        for_darks=True,
        for_whites=True,
        whitens=True,
        ingredients=["Sodium lauryl sulfate", "Sodium laureth sulfate"],
        db=db,
    )

    db.close()
