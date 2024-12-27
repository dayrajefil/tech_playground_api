class TempoDeEmpresa < EnumMethods
  associate_values  less_than_one: 0,
                    between_one_and_two: 1,
                    between_two_and_five: 2,
                    more_than_five: 3
end
