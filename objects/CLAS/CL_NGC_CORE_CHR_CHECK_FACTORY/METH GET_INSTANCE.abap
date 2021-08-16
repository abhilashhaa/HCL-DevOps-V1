  METHOD get_instance.

    DATA(ls_instance) = VALUE #( gt_datatype_instance_map[ datatype = iv_charc_data_type ] OPTIONAL ).

    IF ls_instance IS INITIAL.
      CASE iv_charc_data_type.
        WHEN if_ngc_c=>gc_charcdatatype-char.
          ro_instance = cl_ngc_core_chr_check_char=>get_instance( ).

        WHEN if_ngc_c=>gc_charcdatatype-num.
          ro_instance = cl_ngc_core_chr_check_num=>get_instance( ).

        WHEN if_ngc_c=>gc_charcdatatype-curr.
          ro_instance = cl_ngc_core_chr_check_curr=>get_instance( ).

        WHEN if_ngc_c=>gc_charcdatatype-time.
          ro_instance = cl_ngc_core_chr_check_time=>get_instance( ).

        WHEN if_ngc_c=>gc_charcdatatype-date.
          ro_instance = cl_ngc_core_chr_check_date=>get_instance( ).

        WHEN OTHERS.
          RAISE EXCEPTION TYPE cx_ngc_core_chr_exception.
      ENDCASE.

      APPEND VALUE #( datatype = iv_charc_data_type instance = ro_instance ) TO gt_datatype_instance_map.
    ELSE.
      ro_instance = ls_instance-instance.
    ENDIF.

  ENDMETHOD.