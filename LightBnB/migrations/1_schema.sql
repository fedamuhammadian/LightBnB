CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  password TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS properties (
  id SERIAL PRIMARY KEY,
  user_id INTEGER references users(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  cost_per_night INTEGER NOT NULL DEFAULT 0, 
  parking_spaces SMALLINT NOT NULL DEFAULT 0,
  number_of_bathrooms SMALLINT NOT NULL DEFAULT 0,
  number_of_bedrooms SMALLINT NOT NULL DEFAULT 0,
  thumbnail_photo_url TEXT NOT NULL,
  cover_photo_url TEXT NOT NULL,
  street TEXT NOT NULL,
  city TEXT NOT NULL,
  province TEXT NOT NULL,
  country TEXT NOT NULL,
  post_code VARCHAR(6) NOT NULL,
  active BOOLEAN DEFAULT false
);

CREATE TABLE IF NOT EXISTS reservations (
  id SERIAL PRIMARY KEY,
  user_id INTEGER references users(id) ON DELETE CASCADE,
  property_id INTEGER references properties(id) ON DELETE CASCADE,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS property_reviews (
  id SERIAL PRIMARY KEY,
  guest_id INTEGER references users(id) ON DELETE SET NULL,
  property_id INTEGER references properties(id) ON DELETE CASCADE,
  reservation_id INTEGER references reservations(id) ON DELETE SET NULL,
  message TEXT,
  rating SMALLINT NOT NULL DEFAULT 0
);