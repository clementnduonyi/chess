class MoveGenerator
    
    
    def initialize(speciality)
        @shift_class = self.class.const_get("#{speciality}Move")
    end

    def create
        @shift_class.new
    end
end

