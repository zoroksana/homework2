# frozen_string_literal: true

# exercise object model
module ObjectModel
  module Linux_Friendly
    def fork_process
      super
    end

  end

  class Desktop
    def fork_process
      "Parent: allocate memory"
    end
    def mine_bitcoins
      inspect
    end
  end

  class Laptop < Desktop
    prepend Linux_Friendly
  end

end
