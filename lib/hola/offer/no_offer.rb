# frozen_string_literal: true

# When no offer assigned to a product this is should be the class
# for computing subtotal
module Hola
  class Offer
    class NoOffer < Offer
    end
  end
end
