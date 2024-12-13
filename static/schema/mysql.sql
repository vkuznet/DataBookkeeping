CREATE TABLE processing (
    processing_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    processing VARCHAR(255) NOT NULL UNIQUE,
    environment_id BIGINT REFERENCES python_environments(environment_id) ON UPDATE CASCADE,
    os_id BIGINT REFERENCES os_environments(os_id) ON UPDATE CASCADE,
    script_id BIGINT REFERENCES scripts(script_id) ON UPDATE CASCADE,
    create_at INTEGER,
    create_by VARCHAR(255),
    modify_at INTEGER,
    modify_by VARCHAR(255)
);

CREATE TABLE parents (
    parent_id INTEGER NOT NULL,
    dataset_id INTEGER NOT NULL,
    create_at INTEGER,
    create_by VARCHAR(255),
    modify_at INTEGER,
    modify_by VARCHAR(255)
);

CREATE TABLE sites (
    site_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    site VARCHAR(255) NOT NULL UNIQUE,
    create_at INTEGER,
    create_by VARCHAR(255),
    modify_at INTEGER,
    modify_by VARCHAR(255)
);

CREATE TABLE buckets (
    bucket_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    bucket VARCHAR(255) NOT NULL UNIQUE,
    dataset_id BIGINT REFERENCES datasets(dataset_id) ON UPDATE CASCADE,
    create_at INTEGER,
    create_by VARCHAR(255),
    modify_at INTEGER,
    modify_by VARCHAR(255)
);

CREATE TABLE datasets (
    dataset_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    did VARCHAR(255) NOT NULL UNIQUE,
    site_id BIGINT REFERENCES sites(site_id) ON UPDATE CASCADE,
    processing_id BIGINT REFERENCES processing(processing_id) ON UPDATE CASCADE,
    parent_id BIGINT REFERENCES parents(parent_id) ON UPDATE CASCADE,
    create_at INTEGER,
    create_by VARCHAR(255),
    modify_at INTEGER,
    modify_by VARCHAR(255)
);

CREATE TABLE files (
    file_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    file VARCHAR(255) NOT NULL UNIQUE,
    is_file_valid INTEGER DEFAULT 1,
    dataset_id BIGINT REFERENCES datasets(dataset_id) ON UPDATE CASCADE,
    create_at INTEGER,
    create_by VARCHAR(255),
    modify_at INTEGER,
    modify_by VARCHAR(255)
);

-- Python Environments
CREATE TABLE python_environments (
    environment_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,        -- Name of the environment (e.g., conda, virtualenv)
    version VARCHAR(255),              -- Python version
    details TEXT,                      -- Additional environment details
    create_at INTEGER,
    create_by VARCHAR(255),
    modify_at INTEGER,
    modify_by VARCHAR(255)
);

-- OS Environments
CREATE TABLE os_environments (
    os_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    os_name VARCHAR(255) NOT NULL,     -- Operating system name (e.g., Linux)
    os_version VARCHAR(255),           -- Kernel/OS version
    release_number VARCHAR(255),       -- OS release number
    create_at INTEGER,
    create_by VARCHAR(255),
    modify_at INTEGER,
    modify_by VARCHAR(255)
);

-- Scripts
CREATE TABLE scripts (
    script_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    script_name VARCHAR(255) NOT NULL, -- Name of the script
    parameters TEXT,                   -- Parameters used for the script
    create_at INTEGER,
    create_by VARCHAR(255),
    modify_at INTEGER,
    modify_by VARCHAR(255)
);
