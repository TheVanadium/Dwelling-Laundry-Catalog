import sqlite3


def detuple(t: tuple[str]) -> str:
    # remove () and ,
    return str(t).replace("(", "").replace(")", "").replace(",", "").replace("'", "")


def detuple_list(ts: list[tuple[str]]) -> list[str]:
    return [detuple(t) for t in ts]


def connect_db():
    conn = sqlite3.connect("Checkpoint2-dbase.sqlite3")
    return conn


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


def get_washing_methods(
    cleaner_address: str, db: sqlite3.Connection
) -> list[tuple[str, str, str]]:
    cursor = db.cursor()
    cursor.execute(
        f"""
        SELECT wash_method, detergent, dry_method
        FROM SupportsCleaningSystem
        WHERE cleaners = ?;
    """,
        (cleaner_address,),
    )
    washing_methods: list[tuple[str, str, str]] = cursor.fetchall()
    cursor.close()
    return washing_methods


def get_laundry(
    db: sqlite3.Connection, washing_method: tuple[str, str, str], washer: str
) -> list[tuple[int, str, str]]:
    cursor = db.cursor()
    valid_washees: list[str] = detuple_list(
        cursor.execute(
            f"""
        SELECT washee
        FROM OwnerCanWash
        WHERE washer = ?;
    """,
            (washer,),
        ).fetchall()
    )
    valid_washees.append(washer)
    print(valid_washees)
    laundry: list[tuple[int, str, str]] = []
    for washee in valid_washees:
        cursor.execute(
            f"""
            SELECT id, description, name
            FROM laundry
            JOIN CleanedBy ON laundry.id = CleanedBy.laundry
            JOIN Owner
            WHERE wash_method = ?
            AND detergent = ?
            AND dry_method = ?
            AND name = ?
        """,
            (washing_method[0], washing_method[1], washing_method[2], washee),
        )
        laundry.extend(cursor.fetchall())
    cursor.close()
    return laundry


if __name__ == "__main__":
    db = connect_db()
    cursor = db.cursor()

    owner: str = ""
    cursor.execute("SELECT name FROM owner;")
    for name in detuple_list(cursor.fetchall()):
        print(name)
    while not owner:
        owner = input("Enter your name: ")
        cur = db.cursor()
        cur.execute(
            f"""
            SELECT name
            FROM Owner
            WHERE name = ?;
        """,
            (owner,),
        )
        if not cur.fetchone():
            print("Owner not found in database.")
            owner = ""

    cleaner_address: str = ""
    cursor.execute("SELECT name, address FROM cleaners;")
    for cleaner in cursor.fetchall():
        print(cleaner)
    while not cleaner_address:
        print("Select a cleaner:")

        cleaner_address = input("Enter the address of the cleaner: ")
        cursor.execute(
            f"""
            SELECT address
            FROM cleaners
            WHERE address = ?;
        """,
            (cleaner_address,),
        )
        if not cursor.fetchone():
            print("Cleaner not found in database.")
            cleaner_address = ""

    washing_methods = get_washing_methods(cleaner_address, db)
    washing_method_index = -1
    print("Select a washing method number:")
    for i, method in enumerate(washing_methods):
        print(f"{i + 1}. {method}")
    while washing_method_index < 0 or washing_method_index >= len(washing_methods):
        washing_method_index = (
            int(input("Enter the number of the washing method: ")) - 1
        )
        print(washing_method_index)
    laundry = get_laundry(db, washing_methods[washing_method_index], owner)
    print("Select a laundry to clean:")
    for i, item in enumerate(laundry):
        print(f"{i}. {item}")

    cursor.close()
    db.close()