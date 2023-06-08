SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutured = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutured = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


-- Start the transaction
BEGIN;
-- Update the species column to "unspecified"
UPDATE animals
SET species = 'unspecified';
-- Verify the change
SELECT * FROM animals;  -- Verify updated species column
-- Roll back the transaction
ROLLBACK;


-- Start the transaction
BEGIN;
-- Update the animals table by setting the species column to "digimon" for animals whose name ends in "mon"
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
-- Update the animals table by setting the species column to "pokemon" for animals that don't have a species already set
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
-- Verify the changes
SELECT * FROM animals;  -- Verify updated species column
-- Commit the transaction
COMMIT;
-- Verify that changes persist after commit
SELECT * FROM animals;  -- Verify updated species column after commit


-- delete all records in the animals table, then roll back the transaction.
-- After the rollback verify if all records in the animals table still exists. 
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Start the transaction
BEGIN;

-- Delete all animals born after Jan 1st, 2022
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

-- Create a savepoint for the transaction
SAVEPOINT my_savepoint;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO my_savepoint;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

-- Commit the transaction
COMMIT;


-- How many animals are there?
SELECT COUNT(*) AS animal_count
FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) AS no_escape_count
FROM animals
WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) AS average_weight
FROM animals;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

-- Write queries using JOIN

BEGIN;

-- Update owner_id for Agumon
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

-- Update owner_id for Gabumon and Pikachu
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

-- Update owner_id for Devimon and Plantmon
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

-- Update owner_id for Charmander, Squirtle, and Blossom
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

-- Update owner_id for Angemon and Boarmon
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');

COMMIT;
