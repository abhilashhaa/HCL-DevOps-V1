CLASS cl_ngc_bil_clf DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE

  GLOBAL FRIENDS cl_ngc_bil_factory
                 tc_ngc_bil_clf
                 tc_ngc_bil_clf_object
                 tc_ngc_bil_clf_transactional .

  PUBLIC SECTION.

    INTERFACES if_ngc_bil_clf_transactional .
    INTERFACES if_ngc_bil_clf .
