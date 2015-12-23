module Csgraph

  module Csound

    #
    # +Conversions+
    #
    # BEWARE: this is a hack. The proper way to do this is to interface
    # +csgraph+ to the +CsoundAPI+ - but we haven't done this yet.
    #
    # Any help is more than welcome.
    #
    module Conversions

      module Actual

        #
        # +PCHBASE+ is the frequency constant of Do-5 => 0.00
        #
        PCHBASE = 1.021875
    
        #
        # +MAXAMP+ is the maximum amplitude when we're running on 16-bit
        # samples.
        # BEWARE: this is a hack: we might be running on different sample
        # sizes (like 24 or 32 bits). In order to do this properly we should
        # link `csgraph` to the `CsoundAPI` and query it for sample size. (TODO)
        #
        MAXAMP = 32768.0

        def ampdb(db)
          10.0**(db.to_f / 20.0)
        end

        def ampdbfs(db)
          ampdb(db) * MAXAMP
        end
  
        def cpspch(pch)
          int_part = pch.to_i
          semi = (pch - int_part) * 100.0
          (PCHBASE * (2 ** (int_part))) * (2 ** (semi / 12.0))
        end
  
        def cpsoct(oct)
          int_part = oct.to_i
          frac = (oct - int_part).to_f
          (PCHBASE * (2 ** (int_part))) * (2 ** (frac))
        end

      end

      module Cached

        Csgraph::Csound::Conversions::Actual.public_instance_methods.each do
          |meth|
          define_method(meth) do
            |val|
            common_converter(meth, val)
          end
        end

      private

        def common_converter(conv, val)
          check_argument(val)
          res = nil
          meth = conv
          if val.is_a?(Csgraph::DSL::PFieldBase)
            val.add_converter(meth)
            res = val
          else
            extend Csgraph::Csound::Conversions::Actual
            res = send(conv, val)
          end
          res
        end

        def check_argument(arg)
          raise ArgumentError, "Wrong argument type \"#{arg.class.name}\" (should be a Numeric or a PFieldBase)" unless arg.is_a?(Csgraph::DSL::PFieldBase) || arg.is_a?(Numeric)
        end

      end

    end

  end

end
