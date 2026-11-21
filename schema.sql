PRAGMA foreign_keys = ON;

CREATE TABLE sales (
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id        INTEGER NOT NULL,
    customer_id    INTEGER,                       -- empty for cash sales
    payment_method TEXT    NOT NULL
                   CHECK (payment_method IN ('cash', 'credit')),
    total          INTEGER NOT NULL CHECK (total >= 0),  -- whole XAF
    created_at     TEXT    NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (user_id)     REFERENCES users(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE sale_items (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    sale_id    INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity   INTEGER NOT NULL CHECK (quantity > 0),
    unit_price INTEGER NOT NULL CHECK (unit_price >= 0),  -- price at time of sale
    unit_cost  INTEGER NOT NULL CHECK (unit_cost >= 0),   -- cost at time of sale
    FOREIGN KEY (sale_id)    REFERENCES sales(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id)
);