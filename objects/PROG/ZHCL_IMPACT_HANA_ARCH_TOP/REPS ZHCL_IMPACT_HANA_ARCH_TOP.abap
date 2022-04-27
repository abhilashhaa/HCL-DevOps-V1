*&---------------------------------------------------------------------*
*&  Include           ZHCL_IMPACT_HANA_ARCH_TOP
*&---------------------------------------------------------------------*

*Structure to Read the report into internal table
   TYPES : BEGIN OF t_content,
             line(255),
           END OF t_content,

           BEGIN OF t_fields,
             name TYPE token_str,
           END OF t_fields,

           BEGIN OF t_keywords,
             key(40),
           END OF t_keywords,

           BEGIN OF t_final_alv,
             flag    TYPE flag,
             objtyp  TYPE trobjtype,
             objnam  TYPE sobj_name,
             cpdname TYPE seocpdname,
             line    TYPE token_row,
             errcod  TYPE char10,
             errdsc  TYPE char80,
             recsol  TYPE char80,
           END OF t_final_alv,

           BEGIN OF t_trdir,
             name TYPE progname,
           END OF t_trdir,

           BEGIN OF t_tfdir,
             funcname TYPE rs38l_fnam,
             pname    TYPE pname,
             include  TYPE includenr,
             inclname TYPE progname,
           END OF t_tfdir,

           BEGIN OF t_config,
             pattern_id   TYPE char10,
             pattern_desc TYPE char40,
             error_id     TYPE char10,
             error_desc   TYPE char80,
             rec_sol      TYPE char80,
           END OF t_config,

           tty_final_alv TYPE STANDARD TABLE OF t_final_alv,
           tty_content   TYPE STANDARD TABLE OF t_content,
           tty_keywords  TYPE STANDARD TABLE OF t_keywords.



*---------------------------------------------------------------------*
* Data - Internal Tables
*---------------------------------------------------------------------*
   DATA : gi_final        TYPE STANDARD TABLE OF t_final_alv,
          gs_final        TYPE                   t_final_alv,
          gi_class        TYPE STANDARD TABLE OF seoclskey,
          gs_class        TYPE                   seoclskey,
          gi_cls_incl     TYPE STANDARD TABLE OF seop_method_w_include,
          gi_cls_incl_tmp TYPE STANDARD TABLE OF seop_method_w_include,
          gi_config       TYPE STANDARD TABLE OF t_config,
          gi_trdir        TYPE STANDARD TABLE OF t_trdir,
          gi_tfdir        TYPE STANDARD TABLE OF t_tfdir,
          gi_tfdir_tmp    TYPE STANDARD TABLE OF t_tfdir,
          gs_cls_incl     TYPE                   seop_method_w_include,
          gi_content      TYPE STANDARD TABLE OF t_content,
          gs_content      TYPE                   t_content,
          keyword         LIKE                   stokex-str,
          token           LIKE                   stokex,

          gt_alv          TYPE REF TO            cl_salv_table,
          gi_keywords     TYPE STANDARD TABLE OF t_keywords,
          gs_trdir        TYPE                   t_trdir,
          gv_len          TYPE                   i,
          gv_stat         TYPE                   char1,
          gv_ch           TYPE                   c LENGTH 72,
          gv_prv_objnam   TYPE                   sobj_name,
          gv_flag         TYPE                   char1,
          gv_cnt          TYPE                   i,
          gv_str          LIKE                   stokex-str,
          gv_ch1          TYPE                   c LENGTH 72,
          gv_ch2          TYPE                   c LENGTH 72,
          gv_index        TYPE                   sytabix,
          gv_fn           TYPE                   c LENGTH 72,
          gv_line         TYPE                   i,
          gv_prog         TYPE                   rs38m-programm.

   FIELD-SYMBOLS: <fs_trdir> TYPE t_trdir,
                  <fs_tfdir> TYPE t_tfdir.
   DATA: BEGIN OF i_rep OCCURS 0,
           line(256) TYPE c,
         END OF i_rep.

*data declarations for ALV Main list
   DATA : wa_layout    TYPE slis_layout_alv,
          it_fieldcat  TYPE slis_t_fieldcat_alv,
          i_statements LIKE sstmnt  OCCURS 0 WITH HEADER LINE,
          i_levels     LIKE slevel  OCCURS 0 WITH HEADER LINE,
          i_keywords   LIKE i_rep   OCCURS 0 WITH HEADER LINE,
          i_tokens     LIKE stokex  OCCURS 0 WITH HEADER LINE,

          wa_fieldcat  TYPE slis_fieldcat_alv.

   CONSTANTS: c_1 TYPE char10 VALUE '0000000001',
              c_2 TYPE char10 VALUE '0000000002'.

   SELECTION-SCREEN      BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
   SELECTION-SCREEN BEGIN OF LINE.
   PARAMETERS: rb_prog RADIOBUTTON GROUP grp1.
   SELECTION-SCREEN COMMENT 3(10) text-002 FOR FIELD rb_prog.
   PARAMETERS: rb_fugr RADIOBUTTON GROUP grp1.
   SELECTION-SCREEN COMMENT 15(15) text-003 FOR FIELD rb_fugr.
   PARAMETERS: rb_func RADIOBUTTON GROUP grp1.
   SELECTION-SCREEN COMMENT 34(15) text-004 FOR FIELD rb_func.
   PARAMETERS: rb_clas RADIOBUTTON GROUP grp1.
   SELECTION-SCREEN COMMENT 55(15) text-005 FOR FIELD rb_clas.
   SELECTION-SCREEN END OF LINE.
   SELECTION-SCREEN END OF BLOCK b1.


   SELECT-OPTIONS: s_objnam FOR gv_prog OBLIGATORY.



*   CLASS lcl_handle_events DEFINITION.
*     PUBLIC SECTION.
*
*       METHODS: on_link_click   FOR EVENT link_click OF
*                     cl_salv_events_table
*         IMPORTING row column.
*   ENDCLASS.
*
*
*   CLASS lcl_handle_events IMPLEMENTATION.
*
*     METHOD on_link_click.
*       DATA: ls_final TYPE t_final_alv.
*
*       READ TABLE gi_final INTO ls_final INDEX row.
*       IF sy-subrc = 0.
*         PERFORM f_get_objnam_reverse CHANGING ls_final-objnam
*                                               ls_final-cpdname.
*         CASE column.
*           WHEN 'LINE'.
*             CALL FUNCTION 'EDITOR_PROGRAM'
*               EXPORTING
*                 appid   = 'PG'
*                 display = 'X'
*                 program = ls_final-objnam
*                 line    = ls_final-line
*                 topline = ls_final-line.
*
*         ENDCASE.
*       ENDIF.
*     ENDMETHOD.                    "on_link_click
*   ENDCLASS.
*
*
*   DATA: event_handler TYPE REF TO lcl_handle_events.