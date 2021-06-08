module TaskLogging
  def task(*args, &block)
    Rake::Task.define_task(*args) do |task|
      if block_given?
        Rails.logger.debug "[#{task.name}] started"
        begin
          block.call(task)
          Rails.logger.debug "[#{task.name}] finished"
        rescue => exception
          Rails.logger.debug "[#{task.name}] failed"
          raise exception
        end
      end
    end
  end
end

# Override Rake::DSL#task to inject logging
extend TaskLogging