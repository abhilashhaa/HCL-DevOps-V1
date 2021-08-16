interface IF_NGC_CORE_CLF_LOCKING
  public .


  methods CLEN_ENQUEUE_CLASSIFICATION
    importing
      !IV_ENQMODE type ENQMODE
      !IV_KLART type KLASSENART
      !IV_CLASS type KLASSE_D optional
      !IV_MAFID type KLMAF optional
      !IV_OBJEK type CUOBN optional
    exporting
      !EV_SUBRC type SYST_SUBRC .
  methods CLEN_DEQUEUE_CLASSIFICATION
    importing
      !IV_ENQMODE type ENQMODE
      !IV_KLART type KLASSENART
      !IV_CLASS type KLASSE_D optional
      !IV_MAFID type KLMAF optional
      !IV_OBJEK type CUOBN optional .
  methods CLEN_DEQUEUE_ALL .
  methods DEQUEUE_ECKSSKXE
    importing
      !IV_OBJEK type CUOBN optional .
  methods ENQUEUE_ECKSSKXE
    importing
      !IV_OBJEK type CUOBN optional
    exporting
      !EV_SUBRC type SYST_SUBRC .
endinterface.