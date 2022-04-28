*&---------------------------------------------------------------------*
*& Report ZHCL_UNITTEST_CHECK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZHCL_UNITTEST_CHECK.

*DATA : l_listobject TYPE TABLE OF abaplist.

DATA: ls_data TYPE REF TO data.
FIELD-SYMBOLS: <lt_data> TYPE table.

cl_salv_bs_runtime_info=>set(
display = abap_false
metadata = abap_false
data = abap_true ).

SUBMIT RSUSR002
with obj1 eq 'S_TCODE'
with VAL101 eq 'SM20'
and RETURN.

TRY.
  BREAK-POINT.
cl_salv_bs_runtime_info=>get_data_ref(
IMPORTING r_data = ls_data ).
ASSIGN ls_data->* TO <lt_data>.
if <lt_data> IS ASSIGNED.

ENDIF.
CATCH cx_salv_bs_sc_runtime_info.
MESSAGE 'Unable to retrieve ALV data' TYPE 'E'.
ENDTRY.

*free memory

CALL FUNCTION 'LIST_FREE_MEMORY'
TABLES
listobject = l_listobject
EXCEPTIONS
OTHERS = 1.
IF sy-subrc <> 0.
*MESSAGE e000
*WITH 'fatal error with LIST_FREE_MEMORY. SY-SUBRC=' sy-subrc.
ENDIF.