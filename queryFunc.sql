-- List all laundry items owned by a specific person
-- This one works, test with: WHERE OwnedBy.name = 'Donald'
SELECT laundry.id, laundry.description, laundry.location, laundry.special_instructions, laundry.volume, laundry.dirty
FROM laundry
JOIN OwnedBy ON laundry.id = OwnedBy.id
WHERE OwnedBy.name = :specific_person_name;

-- Get laundry items that a person is allowed to wash
-- This one works, test with: WHERE ocw.washer = 'Donald'
SELECT DISTINCT l.id, l.description, l.location, l.special_instructions, l.volume, l.dirty
FROM laundry l
JOIN OwnedBy o ON l.id = o.id
LEFT JOIN OwnerCanWash ocw ON o.name = ocw.washee
WHERE ocw.washer = :person_name 
   OR o.name = :person_name;

-- Identify compatible detergents for dark/light clothes
-- This works, test with: WHERE (d.for_darks = TRUE AND TRUE)
SELECT DISTINCT d.name
FROM detergent d
WHERE (d.for_darks = TRUE AND :is_dark = TRUE)
   OR (d.for_lights = TRUE AND :is_dark = FALSE);

-- Check allergy information
-- This works, test with: WHERE iat.owner = 'Herbert'
SELECT DISTINCT d.name as detergent_name, di.name as ingredient_name
FROM detergent d
JOIN DetergentComposedOf dco ON d.name = dco.detergent
JOIN detergent_ingredient di ON dco.ingredient = di.name
JOIN IsAllergicTo iat ON di.name = iat.detergent_ingredient
WHERE iat.owner = :owner_name;

-- Find laundry items washed by a specific cleaning system
-- This works, test with: 
-- WHERE cb.wash_method = 'Washing Machine' 
--   AND cb.detergent = 'AllPurpose'
--   AND cb.dry_method = 'Tumble Dry'
SELECT l.id, l.description
FROM laundry l
JOIN CleanedBy cb ON l.id = cb.laundry
WHERE cb.wash_method = :wash_method
  AND cb.detergent = :detergent_name
  AND cb.dry_method = :dry_method;

-- Retrieve laundry history for an item
-- This works, test with: WHERE l.id = 1
SELECT l.id, l.description, cb.wash_method, cb.detergent, cb.dry_method
FROM laundry l
JOIN CleanedBy cb ON l.id = cb.laundry
WHERE l.id = :laundry_id;

-- List cleaners liked by a specific person
-- This returns nothing because no Likes data was inserted
-- Need to add: INSERT INTO Likes (cleaners, owner) VALUES ('1234 Elm St', 'Donald');
SELECT c.address, c.name
FROM cleaners c
JOIN Likes l ON c.address = l.cleaners
WHERE l.owner = :person_name;

-- Identify compatible laundry items for a load
-- This works, test with:
-- WHERE scs.wash_method = 'Washing Machine'
--   AND scs.detergent = 'AllPurpose'
--   AND scs.dry_method = 'Tumble Dry'
SELECT DISTINCT l.id, l.description
FROM laundry l
JOIN CleanedBy cb ON l.id = cb.laundry
JOIN SupportsCleaningSystem scs ON cb.wash_method = scs.wash_method 
    AND cb.detergent = scs.detergent 
    AND cb.dry_method = scs.dry_method
WHERE scs.wash_method = :desired_wash_method
  AND scs.detergent = :desired_detergent
  AND scs.dry_method = :desired_dry_method;

-- Get special instructions for a laundry item
-- This works, test with: WHERE id = 1
SELECT id, description, special_instructions
FROM laundry
WHERE id = :laundry_id;

-- List detergent ingredients
-- This works, test with: WHERE dco.detergent = 'AllPurpose'
SELECT di.name as ingredient_name
FROM detergent_ingredient di
JOIN DetergentComposedOf dco ON di.name = dco.ingredient
WHERE dco.detergent = :detergent_name;