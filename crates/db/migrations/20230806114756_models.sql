-- migrate:up

CREATE TYPE model_type AS ENUM (
    'LLM',
    'Embeddings'
);
COMMENT ON TYPE role IS 'The type of model i.e. LLM or Embeddings';

CREATE TABLE models (
    id SERIAL PRIMARY KEY, 
    model_type model_type NOT NULL,
    name VARCHAR NOT NULL, 
    base_url VARCHAR NOT NULL, 
    api_key VARCHAR, 
    billion_parameters INT NOT NULL, 
    context_size INT NOT NULL, 
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Give access to the application user.
GRANT SELECT, INSERT, UPDATE, DELETE ON models TO ft_application;
GRANT USAGE, SELECT ON models_id_seq TO ft_application;

-- Give access to the readonly user
GRANT SELECT ON models TO ft_readonly;
GRANT SELECT ON models_id_seq TO ft_readonly;

-- migrate:down
DROP TABLE models;
DROP TYPE model_type;