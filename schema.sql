CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutured BOOLEAN,
    weight_kg DECIMAL
);

-- Create a new column called species
ALTER TABLE animals ADD COLUMN species varchar(100);

--Create owners table
CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    age INTEGER
);

--Create species table
CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

-- Remove the existing animals table if it already exists (optional)
DROP TABLE IF EXISTS animals;

-- Create the modified animals table
CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    species_id INT REFERENCES species(id),
    owner_id INT REFERENCES owners(id)
);

-- Add a foreign key constraint for species_id column
ALTER TABLE animals ADD CONSTRAINT fk_species_id
FOREIGN KEY (species_id)
REFERENCES species(id);

-- Add a foreign key constraint for owner_id column
ALTER TABLE animals ADD CONSTRAINT fk_owner_id
FOREIGN KEY (owner_id)
REFERENCES owners(id);
