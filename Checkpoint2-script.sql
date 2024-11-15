--  List all laundry items owned by a specific person
SELECT laundry.id, laundry.description, laundry.location, laundry.special_instructions, laundry.volume
FROM laundry
JOIN OwnedBy ON laundry.id = OwnedBy.id
WHERE OwnedBy.name = 'specific_person_name';

--  Get laundry items that a person is allowed to wash
SELECT laundry.id, laundry.description, laundry.location, laundry.special_instructions, laundry.volume
FROM laundry
JOIN OwnedBy ON laundry.id = OwnedBy.id
JOIN OwnerCanWash ON OwnedBy.name = OwnerCanWash.washee
WHERE OwnerCanWash.washer = 'person_name';

--  Identify compatible detergents for washing dark or light clothes
SELECT detergent.name
FROM detergent
WHERE (detergent.for_darks = TRUE AND 'is_dark' = TRUE)
   OR (detergent.for_lights = TRUE AND 'is_dark' = FALSE);

--  Check allergy information for a specific owner with detergent ingredients
SELECT detergent_ingredient.name
FROM detergent_ingredient
JOIN IsAllergicTo ON detergent_ingredient.name = IsAllergicTo.detergent_ingredient
WHERE IsAllergicTo.owner = 'owner_name';

--  Find laundry items washed by a specific method with a specific detergent
SELECT laundry.id, laundry.description
FROM laundry
JOIN CleanedBy ON laundry.id = CleanedBy.laundry
WHERE CleanedBy.wash_method = 'wash_method'
  AND CleanedBy.detergent = 'detergent_name'
  AND CleanedBy.dry_method = 'dry_method';

--  Retrieve laundry history for an item
SELECT laundry.id, CleanedBy.wash_method, CleanedBy.detergent, CleanedBy.dry_method
FROM laundry
JOIN CleanedBy ON laundry.id = CleanedBy.laundry
WHERE laundry.id = 'laundry_id';

--  List cleaners liked by a specific person
SELECT cleaners.address, cleaners.name
FROM cleaners
JOIN Likes ON cleaners.address = Likes.cleaners
WHERE Likes.owner = 'person_name';

--  Identify compatible laundry items for a load based on wash method and detergent
SELECT laundry.id, laundry.description
FROM laundry
JOIN Deterges ON laundry.id = Deterges.laundry
JOIN SupportsCleaningSystem ON Deterges.detergent = SupportsCleaningSystem.detergent
WHERE SupportsCleaningSystem.wash_method = 'desired_wash_method'
  AND SupportsCleaningSystem.detergent = 'desired_detergent'
  AND SupportsCleaningSystem.dry_method = 'desired_dry_method';

--  Get special instructions for a laundry item
SELECT special_instructions
FROM laundry
WHERE id = 'laundry_id';

--  List detergent ingredients for a specific detergent
SELECT detergent_ingredient.name
FROM detergent_ingredient
JOIN DetergentComposedOf ON detergent_ingredient.name = DetergentComposedOf.ingredient
WHERE DetergentComposedOf.detergent = 'detergent_name';

-- DATA INSERTION
INSERT INTO owner (name) VALUES ('Donald');
INSERT INTO owner (name) VALUES ('Herbert');
INSERT INTO owner (name) VALUES ('Harry');

INSERT INTO OwnerCanWash (washer, washee) VALUES ('Donald', 'Herbert');
INSERT INTO OwnerCanWash (washer, washee) VALUES ('Donald', 'Harry');
INSERT INTO OwnerCanWash (washer, washee) VALUES ('Harry', 'Herbert');
INSERT INTO OwnerCanWash (washer, washee) VALUES ('Herbert', 'Harry');

INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (1, 'T-shirt', 'Closet', 'Machine wash cold', FALSE, 1);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (2, 'T-shirt', 'Closet', 'Machine wash cold', FALSE, 1);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (3, 'Pair of sweats', 'Closet', 'Machine wash warm', FALSE, 2);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (4, 'Pair of jeans', 'Closet', 'Machine wash cold', FALSE, 3);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (5, 'Suit top', 'Closet', 'Dry clean only', FALSE, 4);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (6, 'Suit bottom', 'Closet', 'Dry clean only', FALSE, 4);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (7, 'Button-up shirt', 'Closet', 'Machine wash warm', FALSE, 2);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (8, 'Underpants', 'Dresser', 'Machine wash warm', FALSE, 1);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (9, 'Socks', 'Dresser', 'Machine wash warm', FALSE, 1);

INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (10, 'T-shirt', 'Closet', 'Machine wash cold', FALSE, 1);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (11, 'T-shirt', 'Closet', 'Machine wash cold', FALSE, 1);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (12, 'Pair of sweats', 'Closet', 'Machine wash warm', FALSE, 2);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (13, 'Pair of sweats', 'Closet', 'Machine wash warm', FALSE, 2);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (14, 'Pair of jeans', 'Closet', 'Machine wash cold', FALSE, 3);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (15, 'Suit top', 'Closet', 'Dry clean only', FALSE, 4);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (16, 'Suit bottom', 'Closet', 'Dry clean only', FALSE, 4);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (17, 'Button-up shirt', 'Closet', 'Machine wash warm', FALSE, 2);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (18, 'Underpants', 'Dresser', 'Machine wash warm', FALSE, 1);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (19, 'Socks', 'Dresser', 'Machine wash warm', FALSE, 1);

INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (20, 'T-shirt', 'Closet', 'Machine wash cold', FALSE, 1);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (21, 'T-shirt', 'Closet', 'Machine wash cold', FALSE, 1);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (22, 'Pair of sweats', 'Closet', 'Machine wash warm', FALSE, 2);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (23, 'Pair of jeans', 'Closet', 'Machine wash cold', FALSE, 3);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (24, 'Suit top', 'Closet', 'Dry clean only', FALSE, 4);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (25, 'Suit bottom', 'Closet', 'Dry clean only', FALSE, 4);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (26, 'Button-up shirt', 'Closet', 'Machine wash warm', FALSE, 2);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (27, 'Underpants', 'Dresser', 'Machine wash warm', FALSE, 1);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (28, 'Socks', 'Dresser', 'Machine wash warm', FALSE, 1);
INSERT INTO laundry (id, description, location, special_instructions, dirty, volume) VALUES (29, 'T-shirt', 'Closet', 'Machine wash cold', FALSE, 1);

INSERT INTO IsColor (color, laundry) VALUES ('Blue', 1);
INSERT INTO IsColor (color, laundry) VALUES ('Red', 2);
INSERT INTO IsColor (color, laundry) VALUES ('Gray', 3);
INSERT INTO IsColor (color, laundry) VALUES ('Blue', 4);
INSERT INTO IsColor (color, laundry) VALUES ('Black', 5);
INSERT INTO IsColor (color, laundry) VALUES ('Black', 6);
INSERT INTO IsColor (color, laundry) VALUES ('White', 7);
INSERT INTO IsColor (color, laundry) VALUES ('White', 8);
INSERT INTO IsColor (color, laundry) VALUES ('White', 9);

INSERT INTO IsColor (color, laundry) VALUES ('Blue', 10);
INSERT INTO IsColor (color, laundry) VALUES ('Cyan', 11);
INSERT INTO IsColor (color, laundry) VALUES ('Gray', 12);
INSERT INTO IsColor (color, laundry) VALUES ('Gray', 13);
INSERT INTO IsColor (color, laundry) VALUES ('Blue', 14);
INSERT INTO IsColor (color, laundry) VALUES ('Black', 15);
INSERT INTO IsColor (color, laundry) VALUES ('White', 16);
INSERT INTO IsColor (color, laundry) VALUES ('White', 17);
INSERT INTO IsColor (color, laundry) VALUES ('White', 18);
INSERT INTO IsColor (color, laundry) VALUES ('White', 19);

INSERT INTO IsColor (color, laundry) VALUES ('Yellow', 20);
INSERT INTO IsColor (color, laundry) VALUES ('Blue', 21);
INSERT INTO IsColor (color, laundry) VALUES ('Gray', 22);
INSERT INTO IsColor (color, laundry) VALUES ('Blue', 23);
INSERT INTO IsColor (color, laundry) VALUES ('Black', 24);
INSERT INTO IsColor (color, laundry) VALUES ('Black', 25);
INSERT INTO IsColor (color, laundry) VALUES ('White', 26);
INSERT INTO IsColor (color, laundry) VALUES ('White', 27);
INSERT INTO IsColor (color, laundry) VALUES ('White', 28);
INSERT INTO IsColor (color, laundry) VALUES ('White', 29);

-- ownedby 1-9 by Donald, 10-19 by Herbert, 20-29 by Harry
-- Herbert owns two pairs of sweats
INSERT INTO OwnedBy (name, id) VALUES ('Donald', 1);
INSERT INTO OwnedBy (name, id) VALUES ('Donald', 2);
INSERT INTO OwnedBy (name, id) VALUES ('Donald', 3);
INSERT INTO OwnedBy (name, id) VALUES ('Donald', 4);
INSERT INTO OwnedBy (name, id) VALUES ('Donald', 5);
INSERT INTO OwnedBy (name, id) VALUES ('Donald', 6);
INSERT INTO OwnedBy (name, id) VALUES ('Donald', 7);
INSERT INTO OwnedBy (name, id) VALUES ('Donald', 8);
INSERT INTO OwnedBy (name, id) VALUES ('Donald', 9);

INSERT INTO OwnedBy (name, id) VALUES ('Herbert', 10);
INSERT INTO OwnedBy (name, id) VALUES ('Herbert', 11);
INSERT INTO OwnedBy (name, id) VALUES ('Herbert', 12);
INSERT INTO OwnedBy (name, id) VALUES ('Herbert', 13);
INSERT INTO OwnedBy (name, id) VALUES ('Herbert', 14);
INSERT INTO OwnedBy (name, id) VALUES ('Herbert', 15);
INSERT INTO OwnedBy (name, id) VALUES ('Herbert', 16);
INSERT INTO OwnedBy (name, id) VALUES ('Herbert', 17);
INSERT INTO OwnedBy (name, id) VALUES ('Herbert', 18);
INSERT INTO OwnedBy (name, id) VALUES ('Herbert', 19);

INSERT INTO OwnedBy (name, id) VALUES ('Harry', 20);
INSERT INTO OwnedBy (name, id) VALUES ('Harry', 21);
INSERT INTO OwnedBy (name, id) VALUES ('Harry', 22);
INSERT INTO OwnedBy (name, id) VALUES ('Harry', 23);
INSERT INTO OwnedBy (name, id) VALUES ('Harry', 24);
INSERT INTO OwnedBy (name, id) VALUES ('Harry', 25);
INSERT INTO OwnedBy (name, id) VALUES ('Harry', 26);
INSERT INTO OwnedBy (name, id) VALUES ('Harry', 27);
INSERT INTO OwnedBy (name, id) VALUES ('Harry', 28);
INSERT INTO OwnedBy (name, id) VALUES ('Harry', 29);

INSERT INTO color (color, dark) VALUES ('Blue', TRUE);
INSERT INTO color (color, dark) VALUES ('Red', TRUE);
INSERT INTO color (color, dark) VALUES ('Gray', TRUE);
INSERT INTO color (color, dark) VALUES ('Black', TRUE);
INSERT INTO color (color, dark) VALUES ('White', FALSE);
INSERT INTO color (color, dark) VALUES ('Cyan', FALSE);
INSERT INTO color (color, dark) VALUES ('Yellow', FALSE);

INSERT INTO detergent_ingredient (name) VALUES ('Sodium Lauryl Sulfate');
INSERT INTO IsAllergicTo (owner, detergent_ingredient) VALUES ('Herbert', 'Sodium Lauryl Sulfate');

INSERT INTO cleaners (address, name) VALUES ('1234 Elm St', 'Dry Cleaners R Us');
INSERT INTO cleaners (address, name) VALUES ('Home', 'Washing Machine');

INSERT INTO detergent (name, for_darks, for_lights, whitens) VALUES ('AllPurpose', TRUE, TRUE, FALSE);
INSERT INTO detergent (name, for_darks, for_lights, whitens) VALUES ('DrySolvent', FALSE, FALSE, TRUE);
INSERT INTO detergent (name, for_darks, for_lights, whitens) VALUES ('BadDetergent', FALSE, FALSE, FALSE);

INSERT INTO detergent_ingredient (name) VALUES ('Water');

INSERT INTO DetergentComposedOf (detergent, ingredient) VALUES ('AllPurpose', 'Water');
INSERT INTO DetergentComposedOf (detergent, ingredient) VALUES ('DrySolvent', 'Water');
INSERT INTO DetergentComposedOf (detergent, ingredient) VALUES ('BadDetergent', 'Water');
INSERT INTO DetergentComposedOf (detergent, ingredient) VALUES ('BadDetergent', 'Sodium Lauryl Sulfate');

INSERT INTO cleaning_system (wash_method, detergent, dry_method) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry');
INSERT INTO cleaning_system (wash_method, detergent, dry_method) VALUES ('Washing Machine', 'AllPurpose', 'Hang Dry');
INSERT INTO cleaning_system (wash_method, detergent, dry_method) VALUES ('Washing Machine', 'BadDetergent', 'Tumble Dry');
INSERT INTO cleaning_system (wash_method, detergent, dry_method) VALUES ('Washing Machine', 'BadDetergent', 'Hang Dry');
INSERT INTO cleaning_system (wash_method, detergent, dry_method) VALUES ('Dry Clean', 'DrySolvent', 'Press');

INSERT INTO SupportsCleaningSystem (cleaners, wash_method, detergent, dry_method) VALUES ('Home', 'Washing Machine', 'AllPurpose', 'Tumble Dry');
INSERT INTO SupportsCleaningSystem (cleaners, wash_method, detergent, dry_method) VALUES ('456 Elm St', 'Dry Clean', 'DrySolvent', 'Press');

INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 1);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 2);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 3);

INSERT INTO Likes (cleaners, owner) VALUES ('Home', 'Donald');
INSERT INTO Likes (cleaners, owner) VALUES ('Home', 'Herbert');
INSERT INTO Likes (cleaners, owner) VALUES ('Home', 'Harry');
INSERT INTO Likes (cleaners, owner) VALUES ('456 Elm St', 'Donald');
INSERT INTO Likes (cleaners, owner) VALUES ('456 Elm St', 'Herbert');
INSERT INTO Likes (cleaners, owner) VALUES ('456 Elm St', 'Harry');

INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 1);
INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 2);
INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 3);
INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 4);
INSERT INTO Deterges (detergent, laundry) VALUES ('DrySolvent', 5);
INSERT INTO Deterges (detergent, laundry) VALUES ('DrySolvent', 6);
INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 7);
INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 8);
INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 9);

INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 10);
INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 11);
INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 12);
INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 13);
INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 14);
INSERT INTO Deterges (detergent, laundry) VALUES ('DrySolvent', 15);
INSERT INTO Deterges (detergent, laundry) VALUES ('DrySolvent', 16);
INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 17);
INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 18);
INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 19);

INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 20);
INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 21);
INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 22);
INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 23);
INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 24);
INSERT INTO Deterges (detergent, laundry) VALUES ('DrySolvent', 25);
INSERT INTO Deterges (detergent, laundry) VALUES ('DrySolvent', 26);
INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 27);
INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 28);
INSERT INTO Deterges (detergent, laundry) VALUES ('AllPurpose', 29);

INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 1);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 2);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 3);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 4);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Dry Clean', 'DrySolvent', 'Press', 5);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Dry Clean', 'DrySolvent', 'Press', 6);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 7);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 8);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 9);

INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 10);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 11);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 12);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 13);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 14);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Dry Clean', 'DrySolvent', 'Press', 15);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Dry Clean', 'DrySolvent', 'Press', 16);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 17);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 18);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 19);

INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 20);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 21);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 22);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 23);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 24);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Dry Clean', 'DrySolvent', 'Press', 25);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Dry Clean', 'DrySolvent', 'Press', 26);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 27);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 28);
INSERT INTO CleanedBy (wash_method, detergent, dry_method, laundry) VALUES ('Washing Machine', 'AllPurpose', 'Tumble Dry', 29);


-- DATABASE CREATION

CREATE TABLE owner (
  name VARCHAR(255) PRIMARY KEY
);

CREATE TABLE laundry (
  id INT PRIMARY KEY,
  description VARCHAR(255),
  location VARCHAR(255),
  special_instructions VARCHAR(255),
  dirty BOOLEAN,
  volume INT
);

CREATE TABLE detergent (
  name VARCHAR(255) PRIMARY KEY,
  for_darks BOOLEAN,
  for_lights BOOLEAN,
  whitens BOOLEAN
);

CREATE TABLE detergent_ingredient (
  name VARCHAR(255) PRIMARY KEY
);

CREATE TABLE cleaning_system (
  wash_method VARCHAR(255),
  detergent VARCHAR(255),
  dry_method VARCHAR(255),
  PRIMARY KEY (wash_method, detergent, dry_method),
  FOREIGN KEY (detergent) REFERENCES detergent(name)
);

CREATE TABLE color (
  color VARCHAR(255) PRIMARY KEY,
  dark BOOLEAN
);

CREATE TABLE cleaners (
  address VARCHAR(255) PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE IsColor (
  color VARCHAR(255),
  laundry INT,
  FOREIGN KEY (color) REFERENCES color(color),
  FOREIGN KEY (laundry) REFERENCES laundry(id)
);

CREATE TABLE SupportsCleaningSystem (
  cleaners VARCHAR(255),
  wash_method VARCHAR(255),
  detergent VARCHAR(255),
  dry_method VARCHAR(255),
  PRIMARY KEY (cleaners, wash_method, detergent, dry_method),
  FOREIGN KEY (wash_method, detergent, dry_method) REFERENCES cleaning_system(wash_method, detergent, dry_method),
  FOREIGN KEY (cleaners) REFERENCES cleaners(address)
);

CREATE TABLE CleanedBy (
  wash_method VARCHAR(255),
  detergent VARCHAR(255),
  dry_method VARCHAR(255),
  laundry INT,
  PRIMARY KEY (wash_method, detergent, dry_method, laundry),
  FOREIGN KEY (wash_method, detergent, dry_method) REFERENCES cleaning_system(wash_method, detergent, dry_method),
  FOREIGN KEY (laundry) REFERENCES laundry(id)
);

CREATE TABLE IsAllergicTo (
  owner VARCHAR(255),
  detergent_ingredient VARCHAR(255),
  PRIMARY KEY (owner, detergent_ingredient),
  FOREIGN KEY (owner) REFERENCES owner(name),
  FOREIGN KEY (detergent_ingredient) REFERENCES detergent_ingredient(name)
);

CREATE TABLE Deterges (
  laundry INT,
  detergent VARCHAR(255),
  PRIMARY KEY (laundry, detergent),
  FOREIGN KEY (detergent) REFERENCES detergent(name),
  FOREIGN KEY (laundry) REFERENCES laundry(id)
);

CREATE TABLE DetergentComposedOf (
  detergent VARCHAR(255),
  ingredient VARCHAR(255),
  PRIMARY KEY (detergent, ingredient),
  FOREIGN KEY (detergent) REFERENCES detergent(name),
  FOREIGN KEY (ingredient) REFERENCES detergent_ingredient(name)
);

CREATE TABLE OwnerCanWash (
  washer VARCHAR(255),
  washee VARCHAR(255),
  PRIMARY KEY (washer, washee),
  FOREIGN KEY (washer) REFERENCES owner(name),
  FOREIGN KEY (washee) REFERENCES owner(name)
);

CREATE TABLE OwnedBy (
  name VARCHAR(255),
  id INT,
  PRIMARY KEY (name, id),
  FOREIGN KEY (name) REFERENCES owner(name),
  FOREIGN KEY (id) REFERENCES laundry(id)
);

CREATE TABLE Likes (
  cleaners VARCHAR(255),
  owner VARCHAR(255),
  PRIMARY KEY (cleaners, owner),
  FOREIGN KEY (owner) REFERENCES owner(name),
  FOREIGN KEY (cleaners) REFERENCES cleaners(address)
);
