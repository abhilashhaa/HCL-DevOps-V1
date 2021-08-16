  METHOD check_dependant_version.

    CONSTANTS: lc_message TYPE string VALUE 'Current version is older than required'.

    IF is_dependant-major > is_current-major.
      zcx_abapgit_exception=>raise( lc_message ).
    ELSEIF is_dependant-major < is_current-major.
      RETURN.
    ENDIF.

    IF is_dependant-minor > is_current-minor.
      zcx_abapgit_exception=>raise( lc_message ).
    ELSEIF is_dependant-minor < is_current-minor.
      RETURN.
    ENDIF.

    IF is_dependant-patch > is_current-patch.
      zcx_abapgit_exception=>raise( lc_message ).
    ELSEIF is_dependant-patch < is_current-patch.
      RETURN.
    ENDIF.

    IF is_current-prerelase IS INITIAL.
      RETURN.
    ENDIF.

    CASE is_current-prerelase.
      WHEN 'rc'.
        IF is_dependant-prerelase = ''.
          zcx_abapgit_exception=>raise( lc_message ).
        ENDIF.

      WHEN 'beta'.
        IF is_dependant-prerelase = '' OR is_dependant-prerelase = 'rc'.
          zcx_abapgit_exception=>raise( lc_message ).
        ENDIF.

      WHEN 'alpha'.
        IF is_dependant-prerelase = '' OR is_dependant-prerelase = 'rc' OR is_dependant-prerelase = 'beta'.
          zcx_abapgit_exception=>raise( lc_message ).
        ENDIF.

    ENDCASE.

    IF is_dependant-prerelase = is_current-prerelase AND is_dependant-prerelase_patch > is_current-prerelase_patch.
      zcx_abapgit_exception=>raise( lc_message ).
    ENDIF.

  ENDMETHOD.