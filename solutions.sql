/* Név: Fehér Aladár */

-- FORDÍTÓIRODA FELADAT --

/* 1. Lekérdezés */
SELECT * FROM people
WHERE available = 'true';

/* 2. Lekérdezés */
SELECT SUM(length) FROM docs
WHERE field = 'marketing';

/* 3. Lekérdezés */
SELECT COUNT(*) FROM docs
JOIN languages ON languages.id = docs.language_id
WHERE source_lang = 'Slovakian';

/* 4. Lekérdezés */
SELECT COUNT(*), SUM(unit_price) FROM docs
JOIN languages ON languages.id = docs.language_id
WHERE length <= 5000;

/* 5. Lekérdezés */
SELECT length, field FROM docs
JOIN languages ON languages.id = docs.language_id
WHERE source_lang = 'English' AND target_lang = 'Hungarian'
ORDER BY length DESC;

/* 6. Lekérdezés */
SELECT field, source_lang, target_lang FROM docs
JOIN languages ON languages.id = docs.language_id
WHERE worktime BETWEEN 7 AND 9
ORDER BY source_lang;

/* 7. Lekérdezés */
SELECT name, COUNT(target_lang) AS languages FROM people
JOIN translators ON translators.person_id = people.id
JOIN languages ON languages.id = translators.language_id
WHERE source_lang = 'Hungarian'
GROUP BY name
ORDER BY languages DESC
LIMIT 1;

/* 8. Lekérdezés */
SELECT name FROM people
JOIN translators ON translators.person_id = people.id
JOIN languages ON languages.id = translators.language_id
WHERE available = 'true' AND source_lang = 'Hungarian' AND target_lang IN ('English', 'Russian');
-- Ez nem lett jó, de hátha kapok pár pontot. :D

/* 9. Lekérdezés */
SELECT DISTINCT field, source_lang, target_lang FROM docs
JOIN languages ON languages.id = docs.language_id
ORDER BY field, source_lang;

-- BÚTOROS FELADAT --

/* 1. Feladat */
CREATE TABLE furnitures (
  id SERIAL PRIMARY KEY,
  type VARCHAR(255) NOT NULL,
  color VARCHAR(255) NOT NULL,
  price INT,
  CHECK (price > 0)
);

CREATE TABLE carts (
  id SERIAL PRIMARY KEY,
  furniture_id INT NOT NULL REFERENCES furnitures(id),
  quantity INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CHECK (quantity > 0)
);

/* 2. Feladat */
INSERT INTO furnitures (type, color, price)
VALUES
  ('asztal', 'fekete', 19990),
  ('kerek asztal', 'barna', 20000),
  ('szék', 'fekete', 8900),
  ('forgószék', 'fekete', 114490),
  ('éjjeli szekrény', 'piros', 39900);

INSERT INTO carts (furniture_id, quantity)
VALUES
  (1, 1),
  (2, 1),
  (3, 6),
  (4, 2),
  (5, 2);

/* 3. Feladat */
UPDATE furnitures
SET price = 10000
WHERE type LIKE '%asztal%';

/* 4. Feladat */
ALTER TABLE carts
DROP CONSTRAINT carts_furniture_id_fkey;

ALTER TABLE carts
ADD CONSTRAINT carts_furniture_id_fkey
FOREIGN KEY (furniture_id)
REFERENCES furnitures(id)
ON DELETE CASCADE;

DELETE FROM furnitures
WHERE color = 'piros';

-- FELADATLAP VÉGE --