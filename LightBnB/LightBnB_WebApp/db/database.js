const {Pool} = require('pg');

const pool = new Pool({
  user: 'fedamuhammadian',
  password: 'admin',
  host: 'localhost',
  database: 'lightbnb',
  port: 5432,
});
pool.connect().then(() => {
  console.log("Connected to Database!!");
});


/* Get a single user from the database given their email.*/
const getUserWithEmail = (email) => {
  return pool
    .query(`SELECT * FROM users WHERE email = $1`, [email])
    .then((result) => result.rows[0])
    .catch((err) => err.message);
};

/* Get a single user from the database given their id.*/
const getUserWithId = function (id) {
  return pool
  .query(`SELECT * FROM users WHERE id = $1`, [id])
  .then((result) => {
    return result.rows[0];
  })
  .catch((err) => {
    return err.message;
  });
};

/* Add a new user to the database.*/
const addUser = function (user) {
  return pool
  .query(` INSERT INTO users (name, email, password)
  VALUES ($1, $2, $3)`,  [user.name, user.email, user.password])
  .then((result) => {
    return result.rows[0];
  })
  .catch((err) => {
    return err.message;
  });
};


/* Get all reservations for a single user.*/
const getAllReservations = function (guest_id, limit = 10) {
  return pool
  .query(` SELECT *, properties.cost_per_night, AVG(property_reviews.rating) as average_rating
  FROM reservations 
  JOIN properties ON properties.id = property_id
  JOIN property_reviews ON reservations.id = reservation_id
  WHERE reservations.guest_id = $1
  GROUP BY reservations.id, properties.id, property_reviews.id
  LIMIT $2
  `, [guest_id, limit])
  .then((result) => {
    return result.rows;
  })
  .catch((err) => {
    console.log(err.message);
  });
};

/** Get all properties.*/
const getAllProperties = (options, limit = 10) => {
  const queryParams = [];
  let queryString = `
    SELECT properties.*, properties.cost_per_night, AVG(property_reviews.rating) as average_rating, owner_id 
    FROM properties
    JOIN property_reviews ON properties.id = property_id
    WHERE TRUE
  `;

  if (options.city) {
    queryParams.push(`%${options.city}%`);
    queryString += `AND city LIKE $${queryParams.length} `;
  }

  if (options.minimum_price_per_night) {
    queryParams.push(options.minimum_price_per_night * 100);
    queryString += `AND cost_per_night >= $${queryParams.length} `;
  }

  if (options.maximum_price_per_night) {
    queryParams.push(options.maximum_price_per_night * 100);
    queryString += `AND cost_per_night <= $${queryParams.length} `;
  }

  if (options.minimum_rating) {
    queryParams.push(options.minimum_rating);
    queryString += `AND average_rating >= $${queryParams.length} `;
  }

  if (options.owner_id) {
    queryParams.push(options.owner_id);
    queryString += `AND owner_id >= $${queryParams.length} `;
  }
  queryParams.push(limit);
  queryString += `
    GROUP BY properties.id
    ORDER BY cost_per_night
    LIMIT $${queryParams.length};
  `;

  return pool.query(queryString, queryParams)
    .then((res) => res.rows)
    .catch((err) => err.message);
};

/* Add a property to the database */
const addProperty = (property) => {
  const queryParams = [
    property.owner_id,
    property.title,
    property.description,
    property.thumbnail_photo_url,
    property.cover_photo_url,
    property.cost_per_night,
    property.street,
    property.city,
    property.province,
    property.post_code,
    property.country,
    property.parking_spaces,
    property.number_of_bathrooms,
    property.number_of_bedrooms,
  ];
  let queryString = `
    INSERT INTO properties (
      owner_id,
      title,
      description,
      thumbnail_photo_url,
      cover_photo_url,
      cost_per_night,
      street,
      city,
      province,
      post_code,
      country,
      parking_spaces,
      number_of_bathrooms,
      number_of_bedrooms,
      active
    )
    VALUES (
      $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, true
    )
    RETURNING *`;

  console.log(queryString, queryParams);

  return pool.query(queryString, queryParams)
    .then((res) => res.rows)
    .catch((err) => err.message);
};

module.exports = {
  getUserWithEmail,
  getUserWithId,
  addUser,
  getAllReservations,
  getAllProperties,
  addProperty,
};
