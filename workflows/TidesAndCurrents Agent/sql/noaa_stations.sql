-- Drop existing table if it exists
DROP TABLE IF EXISTS "NOAAStations";

-- Create NOAAStations table
CREATE TABLE "NOAAStations" (
    id SERIAL PRIMARY KEY,
    station_id VARCHAR(50) UNIQUE NOT NULL,
    station_name TEXT NOT NULL,
    state VARCHAR(2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert Texas stations
INSERT INTO "NOAAStations" (station_id, station_name, state) VALUES
('8770570', 'Sabine Pass North', 'TX'),
('8770520', 'Texas Point, Sabine Pass', 'TX'),
('8770475', 'Port Arthur', 'TX'),
('8770971', 'Rollover Pass', 'TX'),
('8771013', 'Eagle Point, Galveston Bay', 'TX'),
('8771341', 'Galveston Bay Entrance, North Jetty', 'TX'),
('8771450', 'Galveston Pier 21', 'TX'),
('8771510', 'Galveston Railroad Bridge', 'TX'),
('8771972', 'Clear Lake', 'TX'),
('8772447', 'San Luis Pass', 'TX'),
('8772985', 'Seadrift', 'TX'),
('8773037', 'Port Lavaca', 'TX'),
('8773259', 'Port O''Connor', 'TX'),
('8773701', 'Port Aransas', 'TX'),
('8774770', 'Port Mansfield', 'TX'),
('8775237', 'Realitos Peninsula', 'TX'),
('8775270', 'South Padre Island Coast Guard Station', 'TX'),
('8775296', 'Port of Brownsville', 'TX'),
('8775792', 'Matagorda City', 'TX'),
('8775870', 'Port of Palacios', 'TX'),
('8776139', 'Aransas Wildlife Refuge', 'TX'),
('8776604', 'Packery Channel', 'TX'),
('8776887', 'USS Lexington, Corpus Christi Bay', 'TX'),
('8776977', 'Port Isabel', 'TX'),
('8779748', 'Manchester', 'TX'),
('8779749', 'Lynchburg Landing', 'TX'),
('8779750', 'Morgans Point, Barbours Cut', 'TX'),
('8779770', 'Rainbow Bridge', 'TX'); 