  METHOD zif_abapgit_object~deserialize.

* You are reminded that this method checks for
*  - validity of data model name with regard to naming conventions
*  - permissions and locks
*  - connection to transport and correction system
*  - insert of data model, model relations and all documentation
*  - update of object tree
*  - releasing of lock


* Is the data model name compliant with naming conventions?
    is_name_permitted( ).

* Access Permission granted?
    access_modify( ).

* Connection to transport and correction system
    corr_insert( iv_package ).

* Insert the data model, relations and documentation
    TRY.
        deserialize_model( io_xml ).
        deserialize_entities( io_xml ).
        deserialize_short_texts( io_xml ).
        deserialize_long_texts( io_xml ).
        update_tree( ).
        access_free( ).

      CATCH zcx_abapgit_exception.

        me->access_free( ).

        zcx_abapgit_exception=>raise( 'Error in deserialisation of UDMO' ).


    ENDTRY.

    " You are reminded that data models are not relevant for activation.


  ENDMETHOD.