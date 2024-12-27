class Cargo < EnumMethods
  associate_values  intern: 0,
                    analyst: 1,
                    coordinator: 2,
                    manager: 3,
                    director: 4
end
