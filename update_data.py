import sqlite3

def connect_db():
    conn = sqlite3.connect("Checkpoint2-dbase.sqlite3")
    return conn

def update_owner(
    name: str,
    new_allergies: list[str] = None,
    new_can_wash: list[str] = None,
    new_liked_cleaners: list[str] = None,
    db: sqlite3.Connection = connect_db()
) -> None:
    cursor = db.cursor()

    try:
        # Verify owner exists
        cursor.execute("SELECT name FROM owner WHERE name = ?;", (name,))
        if not cursor.fetchone():
            print(f"Owner {name} does not exist in the database.")
            return

        if new_allergies is not None:
            # Remove old allergies
            cursor.execute("DELETE FROM IsAllergicTo WHERE owner = ?;", (name,))
            # Add new allergies
            for allergy in new_allergies:
                cursor.execute(
                    "INSERT OR IGNORE INTO detergent_ingredient VALUES (?);", 
                    (allergy,)
                )
                cursor.execute(
                    "INSERT INTO IsAllergicTo VALUES (?, ?);",
                    (name, allergy)
                )

        if new_can_wash is not None:
            # Remove old wash permissions
            cursor.execute("DELETE FROM OwnerCanWash WHERE washer = ?;", (name,))
            # Add new wash permissions
            for washee in new_can_wash:
                cursor.execute(
                    "INSERT INTO OwnerCanWash VALUES (?, ?);",
                    (name, washee)
                )

        if new_liked_cleaners is not None:
            # Remove old likes
            cursor.execute("DELETE FROM Likes WHERE owner = ?;", (name,))
            # Add new likes
            for cleaner in new_liked_cleaners:
                cursor.execute(
                    "INSERT INTO Likes VALUES (?, ?);",
                    (cleaner, name)
                )

        print(f"Owner {name} updated successfully.")
    except sqlite3.Error as e:
        print(f"Error updating owner {name}: {e}")

    cursor.close()
    db.commit()
    db.close()

def update_cleaners(
    address: str,
    new_name: str = None,
    new_supported_systems: list[tuple[str, str, str]] = None,
    db: sqlite3.Connection = connect_db()
) -> None:
    cursor = db.cursor()

    try:
        # Verify cleaner exists
        cursor.execute("SELECT address FROM cleaners WHERE address = ?;", (address,))
        if not cursor.fetchone():
            print(f"Cleaner at {address} does not exist in the database.")
            return

        if new_name is not None:
            cursor.execute(
                "UPDATE cleaners SET name = ? WHERE address = ?;",
                (new_name, address)
            )

        if new_supported_systems is not None:
            # Remove old systems
            cursor.execute("DELETE FROM SupportsCleaningSystem WHERE cleaners = ?;", (address,))
            # Add new systems
            for system in new_supported_systems:
                wash_method, detergent, dry_method = system
                cursor.execute(
                    "INSERT OR IGNORE INTO cleaning_system VALUES (?, ?, ?);",
                    (wash_method, detergent, dry_method)
                )
                cursor.execute(
                    "INSERT INTO SupportsCleaningSystem VALUES (?, ?, ?, ?);",
                    (address, wash_method, detergent, dry_method)
                )

        print(f"Cleaner at {address} updated successfully.")
    except sqlite3.Error as e:
        print(f"Error updating cleaner at {address}: {e}")

    cursor.close()
    db.commit()
    db.close()

def update_laundry(
    laundry_id: int,
    new_description: str = None,
    new_location: str = None,
    new_special_instructions: str = None,
    new_dirty: bool = None,
    new_volume: int = None,
    new_detergents: list[str] = None,
    new_color: str = None,
    new_owner: str = None,
    db: sqlite3.Connection = connect_db()
) -> None:
    cursor = db.cursor()

    try:
        # Verify laundry exists
        cursor.execute("SELECT id FROM laundry WHERE id = ?;", (laundry_id,))
        if not cursor.fetchone():
            print(f"Laundry item {laundry_id} does not exist in the database.")
            return

        # Update main laundry table
        update_fields = []
        update_values = []
        if new_description is not None:
            update_fields.append("description = ?")
            update_values.append(new_description)
        if new_location is not None:
            update_fields.append("location = ?")
            update_values.append(new_location)
        if new_special_instructions is not None:
            update_fields.append("special_instructions = ?")
            update_values.append(new_special_instructions)
        if new_dirty is not None:
            update_fields.append("dirty = ?")
            update_values.append(new_dirty)
        if new_volume is not None:
            update_fields.append("volume = ?")
            update_values.append(new_volume)

        if update_fields:
            update_values.append(laundry_id)
            cursor.execute(
                f"UPDATE laundry SET {', '.join(update_fields)} WHERE id = ?;",
                tuple(update_values)
            )

        if new_detergents is not None:
            # Update detergents
            cursor.execute("DELETE FROM Deterges WHERE laundry = ?;", (laundry_id,))
            for detergent in new_detergents:
                cursor.execute(
                    "INSERT INTO Deterges VALUES (?, ?);",
                    (laundry_id, detergent)
                )

        if new_color is not None:
            # Update color
            cursor.execute("DELETE FROM IsColor WHERE laundry = ?;", (laundry_id,))
            cursor.execute(
                "INSERT INTO IsColor VALUES (?, ?);",
                (new_color, laundry_id)
            )

        if new_owner is not None:
            # Update owner
            cursor.execute("DELETE FROM OwnedBy WHERE id = ?;", (laundry_id,))
            cursor.execute(
                "INSERT INTO OwnedBy VALUES (?, ?);",
                (new_owner, laundry_id)
            )

        print(f"Laundry item {laundry_id} updated successfully.")
    except sqlite3.Error as e:
        print(f"Error updating laundry item {laundry_id}: {e}")

    cursor.close()
    db.commit()
    db.close()

def update_detergent(
    name: str,
    new_for_darks: bool = None,
    new_for_lights: bool = None,
    new_whitens: bool = None,
    new_ingredients: list[str] = None,
    db: sqlite3.Connection = connect_db()
) -> None:
    cursor = db.cursor()

    try:
        # Verify detergent exists
        cursor.execute("SELECT name FROM detergent WHERE name = ?;", (name,))
        if not cursor.fetchone():
            print(f"Detergent {name} does not exist in the database.")
            return

        # Update main detergent table
        update_fields = []
        update_values = []
        if new_for_darks is not None:
            update_fields.append("for_darks = ?")
            update_values.append(new_for_darks)
        if new_for_lights is not None:
            update_fields.append("for_lights = ?")
            update_values.append(new_for_lights)
        if new_whitens is not None:
            update_fields.append("whitens = ?")
            update_values.append(new_whitens)

        if update_fields:
            update_values.append(name)
            cursor.execute(
                f"UPDATE detergent SET {', '.join(update_fields)} WHERE name = ?;",
                tuple(update_values)
            )

        if new_ingredients is not None:
            # Update ingredients
            cursor.execute("DELETE FROM DetergentComposedOf WHERE detergent = ?;", (name,))
            for ingredient in new_ingredients:
                cursor.execute(
                    "INSERT OR IGNORE INTO detergent_ingredient VALUES (?);",
                    (ingredient,)
                )
                cursor.execute(
                    "INSERT INTO DetergentComposedOf VALUES (?, ?);",
                    (name, ingredient)
                )

        print(f"Detergent {name} updated successfully.")
    except sqlite3.Error as e:
        print(f"Error updating detergent {name}: {e}")

    cursor.close()
    db.commit()
    db.close()

if __name__ == "__main__":
    db = connect_db()

    # Update an owner
    update_owner(
        name="John Smith",
        new_allergies=["New Allergen", "Sodium lauryl sulfate"],
        new_can_wash=["Jane Doe", "Bob Smith"],
        new_liked_cleaners=["123 Main St", "456 Oak Ave"]
    )

    # Update a cleaner
    update_cleaners(
        address="123 Main St",
        new_name="Super Quick Clean",
        new_supported_systems=[
            ("Washing Machine", "Tide", "Tumble Dry"),
            ("Dry Clean", "DrySolvent", "Press"),
            ("Hand Wash", "Gentle Soap", "Hang Dry")
        ]
    )

    # Update a laundry item
    update_laundry(
        laundry_id=1,
        new_description="Designer jeans",
        new_location="Master bedroom closet",
        new_special_instructions="Dry clean only",
        new_dirty=True,
        new_volume=2,
        new_detergents=["DrySolvent"],
        new_color="Dark Blue",
        new_owner="John Smith"
    )

    # Update a detergent
    update_detergent(
        name="Tide",
        new_for_darks=True,
        new_for_lights=True,
        new_whitens=False,
        new_ingredients=["Eco-friendly enzyme", "Natural fragrance", "Biodegradable surfactant"]
    )

    db.close()
