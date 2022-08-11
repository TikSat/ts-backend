class Base::Fetch < Base::Operation
  step :build_initial_scope

  private

  def build_initial_scope(_ctx, **)
    raise StandardError, 'Have to be defined in subclasses'
  end
end
