Rails::Engine.prepend(
  Module.new {
    def call(*)
      result = nil
      report = MemoryProfiler.report do
        result = super
      end
      report.pretty_print(retained_strings: 0, allocated_strings: 100, normalize_paths: true)
      result 
    end
  }
)
