INSERT INTO owner (name) VALUES ('Donald');
INSERT INTO owner (name) VALUES ('Herbert');
INSERT INTO owner (name) VALUES ('Harry');

-- PERMISSIONS
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