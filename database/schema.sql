

-- 1. 地址表 (Address)
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(100) NOT NULL,
    state_province VARCHAR(100), -- 省/州，可能为空
    city VARCHAR(100) NOT NULL,
    street VARCHAR(255) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    house_number VARCHAR(50) 
);

-- 2. 公司表 (Company)
CREATE TABLE company (
    company_name VARCHAR(255) NOT NULL PRIMARY KEY,
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES address(address_id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- 3. 电影类型表 (GenreType)
CREATE TABLE genre_type (
    genre_name VARCHAR(100) NOT NULL PRIMARY KEY
);

-- 4. 演员表 (Actors)
CREATE TABLE actors (
    actor_name VARCHAR(255) NOT NULL,
    birth_date DATE,
    nationality VARCHAR(100),
    gender VARCHAR(10),
    PRIMARY KEY (actor_name, birth_date)
);


-- 5. 导演表 (Director)
CREATE TABLE director (
    director_name VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    gender VARCHAR(10),
    PRIMARY KEY(director_name,birth_date)
);

-- 6. 会员状态类型表 (MemberStatusTypes)
CREATE TABLE MemberStatusTypes (
    StatusID INT AUTO_INCREMENT PRIMARY KEY,
    StatusName VARCHAR(50) UNIQUE NOT NULL
);

-- 7. 电影表 (Movies)
CREATE TABLE movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_date DATE,
    charge_per_download DECIMAL(10, 2) NOT NULL CHECK (charge_per_download >= 0),
    company_name VARCHAR(255),
    FOREIGN KEY (company_name) REFERENCES company(company_name) ON DELETE SET NULL ON UPDATE CASCADE
);

-- 8. 电影类型关联表 (Has_Genre)
CREATE TABLE has_genre (
    movie_id INT,
    genre_name VARCHAR(100),
    PRIMARY KEY (movie_id, genre_name),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (genre_name) REFERENCES genre_type(genre_name) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 9. 演员参演电影表 (Act_In)
CREATE TABLE act_in (
    movie_id INT,
    actor_name VARCHAR(255) NOT NULL,
    birth_date DATE,
    role VARCHAR(255) NOT NULL, 
    PRIMARY KEY (movie_id, actor_name,birth_date), 
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (actor_name,birth_date) REFERENCES actors(actor_name,birth_date) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 10. 导演执导电影表 (Direct_Movie)
CREATE TABLE direct_movie (
    movie_id INT,
    director_name VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    PRIMARY KEY (movie_id, director_name,birth_date),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (director_name,birth_date) REFERENCES director(director_name,birth_date) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 11. 会员表 (Members)
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    balance DECIMAL(10, 2) DEFAULT 0.00 CHECK (balance >= 0),
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(50),
    registration_date DATE NOT NULL,
    StatusID INT DEFAULT 1, 
    FOREIGN KEY (StatusID) REFERENCES MemberStatusTypes(StatusID) ON DELETE SET NULL ON UPDATE CASCADE
);

-- 12. 下载记录表 (Download)
CREATE TABLE download (
    download_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    movie_id INT,
    download_timestamp DATETIME NOT NULL, 
    amount DECIMAL(10, 2) NOT NULL CHECK (amount >= 0), 
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE SET NULL ON UPDATE CASCADE, 
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE RESTRICT ON UPDATE CASCADE 
);