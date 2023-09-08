/* adding some data to users table */
INSERT INTO users (name, email, password) 
VALUES ('doug funk', 'funkdoug@gmail.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.'),
       ('jim sparling', 'sparling@gmail.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.'),
       ('lisa queen', 'lisaqueen@gmail.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.');


/* adding some data to properties table */
INSERT INTO properties (
    title, description, owner_id, cover_photo_url, thumbnail_photo_url, cost_per_night, parking_spaces, number_of_bathrooms, number_of_bedrooms, active, province, city, country, street, post_code) 
    VALUES 
    ('Speed lamp', 'description', 1, 'https://images.pexels.com/photos/2086676/pexels-photo-2086676.jpeg?auto=compress&cs=tinysrgb&h=350', 'https://images.pexels.com/photos/2086676/pexels-photo-2086676.jpeg', 1000, 1, 2, 3, true, 'Quebec', 'montreal', 'Canada', '123 palm', '1111'),
    ('Blank corner', 'description2', 2, 'https://images.pexels.com/photos/2121121/pexels-photo-2121121.jpeg?auto=compress&cs=tinysrgb&h=350', 'https://images.pexels.com/photos/2121121/pexels-photo-2121121.jpeg', 2000, 1, 3, 3, false, 'Alberta', 'calgary', 'Canada', '321 voltage', '2222'),
    ('Habit mix', 'description3', 3, 'https://images.pexels.com/photos/2080018/pexels-photo-2080018.jpeg?auto=compress&cs=tinysrgb&h=350', 'https://images.pexels.com/photos/2080018/pexels-photo-2080018.jpeg', 3000, 2, 3, 3, true, 'ontario', 'toronto', 'Canada', '231 freedom', '3333');


/* adding some data to reservations table */
INSERT INTO reservations ( guest_id, property_id, start_date, end_date) 
    VALUES (1, 3, '2023-08-25', '2023-10-20'),
    (2, 2, '2023-08-26', '2023-10-21'),
    (3, 1, '2022-08-27', '2023-10-22');

/* adding some data to review table */
INSERT INTO property_reviews (guest_id, property_id, reservation_id, rating, message) 
    VALUES (1, 1, 1, 4, 'message'),
    (1, 2, 2, 3, 'message'),
    (2, 2, 3, 1, 'message');