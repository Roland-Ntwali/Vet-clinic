INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', '2020-02-03', 0, true, 10.23),
       ('Gabumon', '2018-11-15', 2, true, 8),
       ('Pikachu', '2021-01-07', 1, false, 15.04),
       ('Devimon', '2017-05-12', 5, true, 11),
       ('Charmander', '2020-02-08', 0, false, -11),
       ('Plantmon', '2021-11-15', 2, true, -5.7),
       ('Squirtle', '1993-04-02', 3, false, -12.13),
       ('Angemon', '2005-06-12', 1, true, -45),
       ('Boarmon', '2005-06-07', 7, true, 20.4),
       ('Blossom', '1998-10-13', 3, true, 17),
       ('Ditto', '2022-05-14', 4, true, 22);

-- Insert data into the owners table
INSERT INTO owners (full_name, age) VALUES
    ('Sam Smith', 34),            -- Sam Smith, 34 years old
    ('Jennifer Orwell', 19),      -- Jennifer Orwell, 19 years old
    ('Bob', 45),                  -- Bob, 45 years old
    ('Melody Pond', 77),          -- Melody Pond, 77 years old
    ('Dean Winchester', 14),      -- Dean Winchester, 14 years old
    ('Jodie Whittaker', 38);      -- Jodie Whittaker, 38 years old

    -- Insert data into the species table
INSERT INTO species (name) VALUES
    ('Pokemon'),                  -- Pokemon
    ('Digimon');                  -- Digimon

    -- Update animals to include species_id
UPDATE animals
SET species_id = (CASE
    WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
    ELSE (SELECT id FROM species WHERE name = 'Pokemon')
    END);


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


-- Insert data into the vets table
INSERT INTO vets (name, age, date_of_graduation)
VALUES
    ('Vet William Tatcher', 45, '2000-04-23'),
    ('Vet Maisy Smith', 26, '2019-01-17'),
    ('Vet Stephanie Mendez', 64, '1981-05-04'),
    ('Vet Jack Harkness', 38, '2008-06-08');

    -- Insert data into the specializations table
INSERT INTO specializations (vet_id, species_id)
VALUES
    ((SELECT id FROM vets WHERE name = 'Vet William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon')),
    ((SELECT id FROM vets WHERE name = 'Vet Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Digimon')),
    ((SELECT id FROM vets WHERE name = 'Vet Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Pokemon')),
    ((SELECT id FROM vets WHERE name = 'Vet Jack Harkness'), (SELECT id FROM species WHERE name = 'Digimon'));

    