class Base::Fetch < Base::Operation
  step :build_initial_scope

  def self.inherited(child)
    super

    # Выполнить код после выполнения класса
    #   Позволяет наследовать обявленные в Fetch методы и step'ы
    TracePoint.trace(:end) do |t|
      if child == t.self
        klass = Class.new(child) do
          step :find

          protected

          def find(ctx, scope:, params:, **)
            ctx[:model] = scope.find(params[:id])
          end
        end

        child.const_set(:Single, klass)

        t.disable
      end
    end
  end

  private

  def build_initial_scope(_ctx, **)
    raise StandardError, 'Have to be defined in subclasses'
  end
end
