-- create patients table

CREATE TABLE patients
(
id INT GENERATED BY DEFAULT AS IDENTITY,
	name varchar (200),
	date_of_birth date,
	PRIMARY KEY (id)
	);

CREATE TABLE medical_histories (
id INT GENERATED BY DEFAULT AS IDENTITY,
	admitted_at timestamp,
	patient_id int,
	status varchar (200),
	PRIMARY KEY (id),
	FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE treatments (
id SERIAL PRIMARY KEY,
type VARCHAR(200),
name VARCHAR(200)
);

-- create medi

CREATE TABLE medical_history_treatments (
medical_history_id INT,
treatment_id INT,
FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
FOREIGN KEY (treatment_id) REFERENCES treatments(id),
PRIMARY KEY (medical_history_id, treatment_id)
);

-- 