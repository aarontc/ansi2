class Object
	# Returns all subclasses
	# Named so as to avoid potentially polluting the namespace of the consuming application
	def self.ansi2_extension__subclasses(direct = false)
		classes = []
		if direct
			ObjectSpace.each_object(Class) do |c|
				next unless c.superclass == self
				classes << c
			end
		else
			ObjectSpace.each_object(Class) do |c|
				next unless c.ancestors.include?(self) and (c != self)
				classes << c
			end
		end
		classes
	end
end
