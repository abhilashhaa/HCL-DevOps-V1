PROCESS BEFORE OUTPUT.

MODULE %_INIT_PBO.

MODULE %_PBO_REPORT.

MODULE %_PF_STATUS.

MODULE %_S_MSGTYP.

MODULE %_END_OF_PBO.

PROCESS AFTER INPUT.

  MODULE %_BACK AT EXIT-COMMAND.

  MODULE %_INIT_PAI.

CHAIN.
  FIELD  S_MSGTYP-LOW.
  FIELD  S_MSGTYP-HIGH.
  MODULE %_S_MSGTYP.
ENDCHAIN.


CHAIN.
  FIELD  S_MSGTYP-LOW.
  FIELD  S_MSGTYP-HIGH.
    MODULE %_BLOCK_1000000.
ENDCHAIN.

CHAIN.
  FIELD  S_MSGTYP-LOW.
  FIELD  S_MSGTYP-HIGH.
  MODULE %_END_OF_SCREEN.
  MODULE %_OK_CODE_1000.
ENDCHAIN.