{
  # Add your overlays here
  #
  # my-overlay = import ./my-overlay;
  boost = self: super: super.boost.override {
    python = self.python3;
  };
}

