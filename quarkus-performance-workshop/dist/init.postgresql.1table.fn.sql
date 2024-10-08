CREATE UNLOGGED TABLE members (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY,
    current_balance INTEGER NOT NULL DEFAULT 0,
    balance jsonb NOT NULL DEFAULT '[]'::jsonb
);

INSERT INTO members(id) VALUES (1), (2), (3), (4), (5); 

CREATE EXTENSION pg_prewarm;
SELECT pg_prewarm('members');

CREATE TYPE faermanj_result AS (
  status_code INT,
  body jsonb
);

CREATE OR REPLACE FUNCTION proc_transacao(p_cliente_id INT, p_amount INT, p_kind CHAR, p_description CHAR(10))
RETURNS faermanj_result AS $$
DECLARE
    v_current_balance INT;
    n_current_balance INT;
    v_limit INT;
    transaction_result jsonb;
BEGIN
    -- Set limit based on client ID
    v_limit := CASE p_cliente_id
        WHEN 1 THEN 100000
        WHEN 2 THEN 80000
        WHEN 3 THEN 1000000
        WHEN 4 THEN 10000000
        WHEN 5 THEN 500000
        ELSE -1
    END;

    -- Lock the row for update and get the current balance
    SELECT current_balance INTO v_current_balance FROM members WHERE id = p_cliente_id FOR UPDATE;

    -- Calculate new balance based on transaction type
    IF p_kind = 'd' THEN
        n_current_balance := v_current_balance - p_amount;
        -- Check if new balance is below the limit
        IF (n_current_balance < (-1 * v_limit)) THEN
            -- Transaction would exceed the limit, return error
            RETURN ROW(
                422,
                '{"erro": "Saldo insuficiente"}'::jsonb
            )::faermanj_result;
        END IF;
    ELSE
        n_current_balance := v_current_balance + p_amount;
    END IF;

    -- Update customer record with new balance and transaction in the statement
    UPDATE members 
    SET current_balance = n_current_balance,
        balance = CASE 
                        WHEN (SELECT jsonb_array_length(balance) FROM members WHERE id = p_cliente_id) > 10 
                        THEN jsonb_build_array(
                                jsonb_build_object(
                                    'amount', p_amount,
                                    'kind', p_kind,
                                    'description', p_description
                                )
                             ) || balance #- '{-1}'
                        ELSE jsonb_build_array(
                                jsonb_build_object(
                                    'amount', p_amount,
                                    'kind', p_kind,
                                    'description', p_description
                                )
                             ) || balance
                      END
    WHERE id = p_cliente_id;

    -- Return the result as a faermanj_result type directly
    RETURN ROW(
        200,
        json_build_object(
            'current_balance', n_current_balance,
            'limit', v_limit
        )::jsonb
    )::faermanj_result;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION proc_balance(p_cliente_id int)
RETURNS faermanj_result AS $$
BEGIN
    RETURN (
        SELECT ROW(
            200,
            json_build_object(
                'current_balance', json_build_object(
                    'total', current_balance,
                    'date_balance', '1980-01-09 16:20:00.000000',
                    'limit', CASE p_cliente_id
                                WHEN 1 THEN 100000
                                WHEN 2 THEN 80000
                                WHEN 3 THEN 1000000
                                WHEN 4 THEN 10000000
                                WHEN 5 THEN 500000
                                ELSE -1
                              END
                ),
                'recent_transactions', balance
            )
        )::faermanj_result
        FROM members
        WHERE id = p_cliente_id
    );
END;
$$ LANGUAGE plpgsql;

