INSERT INTO utenti (nome, cognome, email, password_hash)
SELECT * FROM (VALUES
    ('Luca', 'Rossi', 'luca.rossi@example.com', '$2a$12$123456789012345678901uVbD8vW8KkY3pYROnI9UuKtCtzB8xOoW'),
    ('Giulia', 'Verdi', 'giulia.verdi@example.com', '$2a$12$123456789012345678901uVbD8vW8KkY3pYROnI9UuKtCtzB8xOoW'),
    ('Marco', 'Bianchi', 'marco.bianchi@example.com', '$2a$12$123456789012345678901uVbD8vW8KkY3pYROnI9UuKtCtzB8xOoW'),
    ('Sara', 'Neri', 'sara.neri@example.com', '$2a$12$123456789012345678901uVbD8vW8KkY3pYROnI9UuKtCtzB8xOoW'),
    ('Alessandro', 'Gialli', 'alessandro.gialli@example.com', '$2a$12$123456789012345678901uVbD8vW8KkY3pYROnI9UuKtCtzB8xOoW')
) AS nuovi_utenti(nome, cognome, email, password_hash)
WHERE NOT EXISTS (
    SELECT 1 FROM utenti u WHERE u.email = nuovi_utenti.email
);
