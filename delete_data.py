import sqlite3


def connect_db():
    conn = sqlite3.connect("Checkpoint2-dbase.sqlite3")
    return conn

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

if __name__ == "__main__":
    db = connect_db()

    # Example usage:
    delete_laundry(1, db)
    delete_detergent("Tide", db)
    delete_owner("John Smith", db)
    delete_cleaners("123 Main St", db)

    db.close()
