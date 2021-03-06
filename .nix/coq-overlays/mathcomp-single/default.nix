{ mathcomp, coq-elpi, hierarchy-builder, version ? null }:
(mathcomp.override {single = true;}).overrideAttrs (old: {
  patchPhase = ''
    sed -i '/STOP\./Q' mathcomp/ssreflect/order.v
    echo "End Order." >> mathcomp/ssreflect/order.v
  '';
  buildPhase = ''
    make -j$NIX_BUILD_CORES -C mathcomp only\
      TGTS="fingroup/presentation.vo algebra/ssralg.vo ssreflect/order.vo"
  '';
  propagatedBuildInputs = old.propagatedBuildInputs ++
                          [ coq-elpi hierarchy-builder ];
  installPhase = "echo NO INSTALL";
})
