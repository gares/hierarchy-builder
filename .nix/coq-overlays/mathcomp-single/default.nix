{ mathcomp, coq-elpi, hierarchy-builder, version ? null }:
(mathcomp.override {single = true;}).overrideAttrs (old: {
  buildPhase = "make -j $(max_jobs) -C mathcomp ./algebra/ssralg.vo";
  propagatedBuildInputs = old.propagatedBuildInputs ++
                          [ coq-elpi hierarchy-builder ];
  installPhase = "echo NO INSTALL";
  doCheck = true;
  checkPhase = ''
    make -C mathcomp clean
    COQ_ELPI_ATTRIBUTES=log_hb make -j $(max_jobs) -C mathcomp ./algebra/ssralg.vo
    hb patch `find . -name \*.v`
    make -j $(max_jobs) -C mathcomp ./algebra/ssralg.vo
  '';
})
