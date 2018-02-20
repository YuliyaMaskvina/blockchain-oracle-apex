-- Create Before Insert Trigger
CREATE OR REPLACE TRIGGER BLOCKCHAIN_SCHEMA.blockchain_bi_trg
  BEFORE INSERT ON blockchain
  FOR EACH ROW
DECLARE
BEGIN
  IF :new.bc_index IS NULL THEN
    :new.bc_index := blockchain_seq.nextval;
  END IF;
END;
